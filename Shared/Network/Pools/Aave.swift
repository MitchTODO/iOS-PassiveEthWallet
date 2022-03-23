//
//  Aave.swift
//  PassiveWallet
//
//  Created by Mitch on 2/25/22.
//

import Foundation

class Aave {
    // MARK: getAaveV2AddressBalance
    // Given chainId and address , return a list of Aave v2 address balances, supply and borrow positions.
    func getAaveV2AddressBalance(chainId:Int,address:String) {
        // https://api.covalenthq.com/v1/:chain_id/address/:address/stacks/aave_v2/balances/?&key=ckey_61ffb0417c1c496b91f1ae27ff2
    }
    // MARK: getAaveAddressBalance
    // Given address , return a list of Aave address balances, supply and borrow positions.
    func getAaveAddressBalance(address:String) {
        // https://api.covalenthq.com/v1/1/address/:address/stacks/aave/balances/?&key=ckey_61ffb0417c1c496b91f1ae27ff2
    }
}
