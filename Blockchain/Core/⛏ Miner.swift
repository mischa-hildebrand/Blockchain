//
//  Miner.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/16/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

public typealias HashCondition = (Hash) -> Bool

public class Miner<T: DataConvertible> {

    /// The miner's wallet which is used for mining rewards.
    let wallet: Wallet
    
    /// The condition that has to be met by a hash to be considered valid.
    let hashCondition: HashCondition
    
    /// The miner's personal copy of the blockchain on which she / he operates.
    var blockchain = Blockchain<T>()
    
    /// The hash condition that is used by default if no condition is specified.
    public static var defaultHashCondition: HashCondition {
        return { hash in
            hash.beginsWith(numberOfLeadingZeroes: 4)
        }
    }
    
    public init(wallet: Wallet = Wallet(), hashCondition: @escaping HashCondition = defaultHashCondition) {
        self.wallet = wallet
        self.hashCondition = hashCondition
    }
    
    /// Mines the `block` by finding a nonce that satisfies the hash condition
    /// and adds it to the miner's blockchain.
    ///
    /// - Parameter block: The block to be mined.
    public func mine(block: inout Block<T>) {
        while !block.hash.satisfies(hashCondition) {
            block.content.nonce += 1
        }
        blockchain.add(block)
    }
    
}

private extension Hash {
    
    /// Convenience function for better code readability.
    ///
    /// - Parameter condition: A condition that the hash must satisfy.
    /// - Returns: `true` is the condition is satisfied, else `false.
    func satisfies(_ condition: HashCondition) -> Bool {
        return condition(self)
    }
    
}
