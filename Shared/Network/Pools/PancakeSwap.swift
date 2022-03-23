//
//  PancakeSwap.swift
//  PassiveWallet
//
//  Created by Mitch on 2/25/22.
//

import Foundation

// Only working on network 56
class PancakeSwap:ObservableObject {
    
    // MARK: getPancakeSwapAddressBalance
    // Given wallet address , return a list of Pancake exchange balances.
    func getPancakeSwapAddressBalance() {
        // https://api.covalenthq.com/v1/56/address/:address/stacks/pancakeswap/balances/?&key=ckey_61ffb0417c1c496b91f1ae27ff2
    }
    
    // MARK: getPancakeSwapV2AddressBalance
    // Given wallet address , return a list of Pancake V2 exchange balances.
    func getPancakeSwapV2AddresBalance() {
        // https://api.covalenthq.com/v1/56/address/0x6dD91BdaB368282dc4Ea4f4beFc831b78a7C38C0/stacks/pancakeswap_v2/balances/?quote-currency=USD&format=JSON&key=ckey_61ffb0417c1c496b91f1ae27ff2
    }
    
    
    
    
    
    
    
}
