//
//  Utils.swift
//  PassiveWallet
//
//  Created by Mitch on 2/25/22.
//

import Foundation

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
