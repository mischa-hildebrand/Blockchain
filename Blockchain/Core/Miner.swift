//
//  Miner.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/16/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

class Miner<T: DataConvertible> {

    let wallet: Wallet
    
    init(wallet: Wallet = Wallet()) {
        self.wallet = wallet
    }
    
    func mine(block: Block<T>) -> Block<T> {
        // TODO
        return block
    }
    
}
