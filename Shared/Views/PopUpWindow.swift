//
//  PopUpWindow.swift
//  PassiveWallet
//
//  Created by Mitch on 2/14/22.
//

import SwiftUI
import CodeScanner
import CoreData
import PromiseKit
import web3swift
/// 983110309620D911731Ac0932219af06091b6744
///


struct PopUpWindow: View {
    //
    @Binding var showPopUp: Bool

    @StateObject var web:BaseWeb3

    /// Scanner state
    @State private var isShowingScanner = false
    
    /// The value currently edited
    @State var fieldName: String = ""
    @State var fieldAddress: String = ""
    
    @State private var addressFromEns:String = ""
    
    @State private var useEns:Bool = false
    
    // Managed Object
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        ZStack {
            if showPopUp {
                Color.black.opacity(showPopUp ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    showPopUp = false
                }
                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    
                    TextField("Wallet Name", text: $fieldName)
                        .frame(width: 250, alignment: .leading)
                        .padding(2)
                        .padding(.top,24)
                        .disableAutocorrection(true)
       
                    Divider()
                 
                    HStack() {
                        
                        TextField("Address / ENS",text: $fieldAddress)
                            .frame(width: 250, alignment: .leading)
                            .padding(2)
                            .padding(.top,25)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            //.textInputAutocapitalization(.never)
                            
                            .onChange(of: fieldAddress, perform: { newValue in
                                    if newValue.contains("0x") {
                                         if newValue.count == 42 { /// eth address is only 42 char
                                             useEns = false
                                             let ethAddress = EthereumAddress(newValue)
                                             let newAddress = ethAddress!.address
                                             
                                             firstly{
                                                 web.addressToEns(address: newAddress)
                                             }.done { value in
                                                 addressFromEns = value
                                             }.catch{ error in
                                                 print(error)
                                             }
                                         }
                                     } else if newValue.contains(".eth") || newValue.contains(".ETH") {
                                         /// Asycn call for ENS name
                                         useEns = true
                                         firstly {
                                             web.ensToAddress(ens: newValue)
                                         }.done { value in
                                             addressFromEns = value
                                         }.catch{ error in
                                             print(error)
                                         }
                                        
                                     } else{
                                         addressFromEns = ""
                                     }
                                 
                            })
                        
                        Button("Scan QR") {
                            isShowingScanner = true
                        }
                        
                    }
                    Divider()
                    
                    Text(addressFromEns)
                        .font(.custom("Helvetica Neue", size: 13))
                        
                    
                    Button(action: addWallet) {
                        Text("Add")
                              .padding(10.0)
                              .overlay(
                                  RoundedRectangle(cornerRadius: 10.0)
                                      .stroke(lineWidth: 2.0)
                                      .shadow(color: .blue, radius: 10.0)
                              )
                    }
                }
                .frame(maxWidth: 300)
                .background(Color.white)
                .contentShape(Rectangle())
                .cornerRadius(16)
                
                .clipped()
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "brad.eth", completion: handleScan)
                }

                
                
            }
        }
        
    }
    
    
    private func addWallet() {
        if fieldName.isEmpty {return}
        
        let address = (useEns) ? addressFromEns : fieldAddress
        
        //for account in savedAcounts{
        //    if address == account.address {return }
            //if address == account.ens {return }
        //}
            
        let newItem = Account(context: viewContext)
        newItem.address = address
        newItem.name = fieldName
        
        do {
            // Save context
            try viewContext.save()
            
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        showPopUp = false
    }
    
    struct MetaMaskQR:Decodable {
        var ethereum:String
    }
    
    func handleScan(result:Swift.Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            /// Must be an address
            if result.string.contains("0x"){
                let details = result.string.components(separatedBy: ":")
                fieldAddress = details[1]
            }
            /// must be a ens only using eth for now
            else if result.string.contains(".eth") || result.string.contains(".ETH"){
                fieldAddress = result.string
            }

        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    private func scanQR() {
        isShowingScanner = true
    }
    
    private func addAddress() {
        withAnimation(.linear(duration: 0.3)) {
            showPopUp = false
        }
    }
    
}

struct PopUpWindow_Previews: PreviewProvider {
    static var previews: some View {
        PopUpWindow(showPopUp: .constant(true), web: BaseWeb3(provider: .Mainnet), fieldName: "N", fieldAddress: "A")
    }
}
