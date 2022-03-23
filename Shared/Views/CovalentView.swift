//
//  CovalentView.swift
//  PassiveWallet
//
//  Created by Mitch on 3/22/22.
//

import SwiftUI
import BigInt
import web3swift

struct CovalentView: View {
    
    @ObservedObject var covalentItem:CovalentItem

    
    init(name:String,address:String){

        let ci = CovalentItem(name: name, address: address)
        self.covalentItem = ci
        fetchBalances(item: ci)

    }
    
    var body: some View {
        
        NavigationLink {
            
            if covalentItem.assets == nil {
                Text(covalentItem.address)
            }else{
                WalletView(item:covalentItem)
            }
            
        } label: {
            VStack{
                
                Text(covalentItem.name).font(Font.custom("TitilliumWeb-SemiBold", size: 18))
                Text(covalentItem.address)
                    .truncationMode(.middle)
                    .lineLimit(1)
                
                HStack {
                    Text("\(covalentItem.ethBalance) ETH")
                    Text("$\(Int(covalentItem.quote)) USD")
                }
            }
        }
    }
    
   func fetchBalances(item:CovalentItem) {
        
        // set up url
        
       guard let url = URL(string:"https://api.covalenthq.com/v1/1/address/\(item.address)/balances_v2/?quote-currency=USD&format=JSON&nft=false&no-nft-fetch=false&key=\(cKey)") else {fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with:urlRequest){(data,response,error) in
            if let error = error {
                print("Request Error:",error)
                return
            }
            guard let response = response as? HTTPURLResponse else {return}
            
            if response.statusCode == 200 {
                guard let data = data else {return}
                DispatchQueue.main.async { 
                    do {
                        // Decode object into covalent object
                        let decodedBalance = try JSONDecoder().decode(CovalentObject.self, from: data)
            
                        var realTokens:[Token] = []
                        // could add up all token quotes for a full balance
                        for token in decodedBalance.data.items{
                            
                            if token.contractTickerSymbol == "ETH" {
                                
                                // Fix for eth being a token 🤷‍♂️
                                let bigGBlance = BigInt(token.balance!)
                                let balance = Web3.Utils.formatToEthereumUnits(bigGBlance!, toUnits: .eth, decimals:4)
                                
                                self.covalentItem.ethBalance = balance!
                                self.covalentItem.quote = token.quote ?? 0.00
                            }else{
                                // add every token except ETH
                                realTokens.append(token)
                            }
                        }
                        covalentItem.assets = decodedBalance.data
                        
                    } catch let error {
                        print("Error decoding:",error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
}

struct CovalentView_Previews: PreviewProvider {
    static var previews: some View {
        CovalentView(name: "Test", address: "Address")
    }
}
