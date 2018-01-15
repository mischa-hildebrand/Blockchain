//
//  Blockchain.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/13/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

public struct Blockchain<T: DataConvertible> {
    
    /// The chain of blocks.
    var blocks: [Block<T>] = []
    
    /// Checks if a block in the chain is valid at the given index
    /// by validating that the block's hash is correct and its previous hash
    /// is equal to the previous block's hash.
    ///
    /// - Parameter index: The index of the block in the chain to be validated.
    /// - Returns: `true` if the block is valid, else `false`.
    public func isBlockValid(at index: Int) -> Bool {
        let previousBlock = blocks[index - 1]
        let currentBlock = blocks[index]
        
        // Validate that the block's previous hash is equal to the previous block's hash.
        guard currentBlock.content.previousHash == previousBlock.hash else {
            return false
        }
        
        // Validate that the block's hash is correct.
        guard currentBlock.hash == currentBlock.content.hashValue else {
            return false
        }
        
        return true
    }
    
}
