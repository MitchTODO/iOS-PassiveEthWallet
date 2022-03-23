//
//  QRCodeScannerView.swift
//  PassiveWallet
//
//  Created by Mitch on 2/14/22.
//

import SwiftUI
import CodeScanner

struct QRCodeScannerView: View {
    @State private var isPresentingScanner = false
    @State private var scannedAddress: String?
    
    var body: some View {
        VStack(spacing: 10) {
            if let code = scannedAddress {
                //print("Next destination")
                
                //NavigationLink("Next page", destination: NextView(scannedCode: ), isActive: .constant(true)).hidden()
            }
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "0x983110309620D911731Ac0932219af06091b6744", completion: handleScan)
        }
    }
    
    func handleScan(result:Result<ScanResult, ScanError>) {
        isPresentingScanner = false
        switch result {
        case .success(let result):
            /// Must be an address
            if result.string.contains("0x"){
                let details = result.string.components(separatedBy: "0x")
                
            }
            /// must be a ens
            else if result.string.contains(".eth") || result.string.contains(".ETH"){
                let details = result.string.components(separatedBy: "0x")
                
            }
            print(result.string)
            
            //guard details.count == 2 else { return }
            //print(details[0]["ethereum"])
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
}

struct QRCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerView()
    }
}
