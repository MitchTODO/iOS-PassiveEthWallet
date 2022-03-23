//
//  WalletView.swift
//  PassiveWallet
//
//  Created by Mitch on 2/17/22.
//

import SwiftUI
import PromiseKit
import web3swift
import BigInt

struct WalletView: View {
    @State private var selected = 0
    @State var item:CovalentItem
    
    /// Current options for covalent pools
    @State private var pools:[String] = ["Uniswap","Xy=K","Pancakeswap","Sushiswap","Aave","Compound","Curve","Balancer"]
    
    var body: some View {
        
        Picker("What is your favorite color?", selection: $selected) {
                        Text("Tokens ").tag(0)
                        Text("Pools").tag(1)
                    }
                    .pickerStyle(.segmented)
        Spacer()
            .navigationTitle(item.name) // Could use ens name
            .navigationBarTitleDisplayMode(.inline).onAppear{
            //for token in account.items {
                //print(token.balance)
                //print(token.contractDecimals)
            //}
        }
        if(selected == 0){
            /// Fix naming
            List(item.assets!.items, id:\.contractAddress) { token in
                VStack(alignment: .leading, spacing: 10) {
                    /// Skip if balance and 24hr balance is zero and type is dust
                    let bigGBlance = BigInt(token.balance!)
    
                    let balance = Web3.Utils.formatToPrecision(bigGBlance!, numberDecimals: token.contractDecimals, formattingDecimals: 4)
                    let intNumber = Double(balance!)
                    let formatedBalance = intNumber!.withCommas()

                    HStack {
                        //AsyncImage(
                        //    url: URL(string: token.logoURL!),
                        //    content: { image in
                        //        image.resizable()
                        //            .aspectRatio(contentMode: .fit)
                        //            .frame(maxWidth: 50, maxHeight: 50)
                        //    },
                        //    placeholder: {
                        //        ProgressView()
                        //    }
                        //)
                         
                        Text(token.contractName!)
                        Text("(\(token.contractTickerSymbol!))")
                    }
                    Text("\(formatedBalance) \(token.contractTickerSymbol!)")
                    //Text("24Hr balance \(token.balance24H)") // if not zero add difference sub
                    
                }
            }
        } else {
            List(pools, id:\.self) {  pool in
                Text(pool)
            }
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addPool) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
}

private func addPool() {
    // Show pool table :>
}

/*
 .task{
     
     guard let url = URL(string: "https://api.covalenthq.com/v1/1/address/\(String(describing: account.address!))/balances_v2/?&key=ckey_61ffb0417c1c496b91f1ae27ff2") else { fatalError("Missing or invalid URL") }

     let urlRequest = URLRequest(url: url)

     let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
         if let error = error {
             print("Request error: ", error)
             return
         }

         guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
         guard let data = data else { return }
                 do {
                     let decodedItems = try JSONDecoder().decode(Balance.self, from: data)
                     var validTokens:[Item] = []
                     var tokenSmybols:[String] = []
                     for token in decodedItems.data.items {
                         // Eth is not a token
                         if token.contractTickerSymbol != "ETH" {
                             validTokens.append(token)
                         }
                     }
                     self.tokenBalance = validTokens
          } catch {
                  print("Error fetching token decoding", error)
          }
     }

     dataTask.resume()
     
 }
 */


struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        let data = CovalentItem(name: "Test", address: "Test")
        WalletView(item:data)
    }
}
