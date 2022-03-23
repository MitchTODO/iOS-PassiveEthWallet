//
//  Accounts.swift
//  PassiveWallet
//
//  Created by Mitch on 2/25/22.
//

import Foundation
import SwiftUI

class CovalentItem:ObservableObject {
    
    var address:String = ""
    @Published var ethBalance:String = "0"
    var quote:Double = 0.00
    var ens:String? = nil
    var name:String = ""
    var queried:Bool = false
    var assets:AddressAssets? = nil
    
    init(name:String, address:String){
        self.address = address
        self.name = name
    }
}
