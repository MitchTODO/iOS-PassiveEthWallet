//
//  Uniswap.swift
//  PassiveWallet
//
//  Created by Mitch on 2/23/22.
//

import Foundation

class Uniswap:ObservableObject {
    var network:Int?
    var address:String?
    init(network:Int,address:String){
        self.network = network
        self.address = address
    }
    
    private func buildUrl (version:String,path:String,address:String?) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.covalenthq.com"
        components.path = "/v1/\(String(describing: self.network))"
        components.queryItems = [
            URLQueryItem(name: "key", value:"ckey_61ffb0417c1c496b91f1ae27ff2" )
        ]
        
        var url = components.url!
        url = url.appendingPathComponent(version)
        url = url.appendingPathComponent(path)
        if address != nil { url = url.appendingPathComponent(address!) }
        
        return url
        
    }
    

    // MARK: getAddressExchangeLiquidtyV2
    // Given address , return a list of liquidity additions and removals. Optionally include swaps as well if requested.
    func getAddressExchangeLiquidityV2(address:String,swaps:Bool) {
        //https://api.covalenthq.com/v1/1/address/:address/stacks/uniswap_v2/balances/?&key=ckey_61ffb0417c1c496b91f1ae27ff2
    }
    
    // MARK: getAddressExchangeBalanceV2
    // Given address, return pool balances across all Uniswap v2 pools and their quote rates.
    func getAddressExchangeBalancesV2(address:String) {
        // https://api.covalenthq.com/v1/1/address/0x6dD91BdaB368282dc4Ea4f4beFc831b78a7C38C0/stacks/uniswap_v2/acts/?quote-currency=USD&format=JSON&swaps=false&key=ckey_61ffb0417c1c496b91f1ae27ff2
    }
    
    // MARK: getAddressExchangeBalanceV1
    // Given address, return pool balances across all Uniswap pools and their quote rates.
    func getAddressExchangeBalancesV1(address:String) {
        // https://api.covalenthq.com/v1/1/address/0x6dD91BdaB368282dc4Ea4f4beFc831b78a7C38C0/stacks/uniswap_v1/balances/?quote-currency=USD&format=JSON&key=ckey_61ffb0417c1c496b91f1ae27ff2
    }
    
}
