//
//  web3.swift
//  PassiveWallet
//
//  Created by Mitch on 2/15/22.
//

import Foundation
import PromiseKit
import web3swift

class BaseWeb3:ObservableObject {
    var w3:web3? = nil
    var ens:ENS? = nil
    
    @Published var ensName = ""
    @Published var addressName = ""
    
    init(provider:Networks){
        self.w3 = web3(provider: InfuraProvider(provider)!)
        self.ens = ENS(web3: w3!)!
    }
    
    public func ensToAddress(ens:String) -> Promise<String> {
        return Promise { seal in
            DispatchQueue.global().async {
                do {
                    let address = try self.ens!.getAddress(forNode: ens).address
                    seal.resolve(.fulfilled(address))
                }catch {
                    seal.reject(error)
                }
                //return address
            }
        }
    }
    
    
    public func addressToEns(address:String) -> Promise<String> {
        return Promise { seal in
            DispatchQueue.global().async {
                do {
                    let resolver = try self.ens!.registry.getResolver(forDomain:".eth")
                    print("resolve \(resolver.resolverContractAddress)")
                    let doSomething = try resolver.getCanonicalName(forNode: address)
                    print("doSome \(doSomething)")
                    
                    //let ens = try self.ens!.getName(forNode:address)
                    
                    seal.resolve(.fulfilled(doSomething))
                } catch {
                    print(error)
                    seal.reject(error)
                }
            }
        }
    }
    
}
