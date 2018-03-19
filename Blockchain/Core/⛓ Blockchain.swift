//
//  Blockchain.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/13/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

public struct Blockchain<T: DataConvertible> {
    
    // MARK: - Data storage properties
    
    /// The first block in the chain. Doesn't contain any payload.
    private let genesisBlock = Block<T>(payload: nil)
    
    /// The chain of blocks.
    private var blocks: [Block<T>] = []
    
    // MARK: - Init
    
    public init() {
        add(genesisBlock)
    }

    // MARK: - Accessing and modifying blocks
    
    /// Adds a `block` to the chain of blocks.
    public mutating func add(_ block: Block<T>) {
        blocks.append(block)
    }
    
    public subscript(index: Int) -> Block<T> {
        return blocks[index]
    }
    
}

// MARK: - Validation

extension Blockchain {
    
    /// Validates if the whole blockchain is valid
    /// by validating every block in the chain.
    public var isValid: Bool {
        for index in blocks.indices {
            guard isBlockValid(at: index) else {
                return false
            }
        }
        return true
    }
    
    /// Checks if a block in the chain is valid at the given index
    /// by validating that the block's hash is correct and its previous hash
    /// is equal to the previous block's hash.
    ///
    /// - Parameter index: The index of the block in the chain to be validated.
    /// - Returns: `true` if the block is valid, else `false`.
    public func isBlockValid(at index: Int) -> Bool {
        
        // Validate that the block's hash is correct.
        guard validateHash(forBlockAt: index) else {
            return false
        }
        
        // Validate that the block's previous hash is equal to the previous block's hash.
        if index > 0 { // except for the genesis block at index 0
            guard validatePreviousHash(forBlockAt: index) else {
                return false
            }
        }
        
        return true
    }
    
    /// Validates that the block's hash is correct.
    ///
    /// - Parameter index: The index of the block in the chain whose hash is to be validated.
    /// - Returns: `true` if the block is valid, else `false`.
    private func validateHash(forBlockAt index: Int) -> Bool {
        let currentBlock = blocks[index]
        return currentBlock.hash == currentBlock.content.hash
    }
    
    /// Validates that the block's previous hash is equal to the previous block's hash.
    ///
    /// - Parameter index: The index of the block in the chain whose previous hash is to be validated.
    /// - Returns: `true` if the block's previous hash is equal to the previous block's hash, else `false`.
    private func validatePreviousHash(forBlockAt index: Int) -> Bool {
        guard index > 0 else {
            fatalError("There is no previous block!")
        }
        let previousBlock = blocks[index - 1]
        let currentBlock = blocks[index]
        
        return currentBlock.content.previousHash == previousBlock.hash
    }
    
}

// MARK: - Collection

extension Blockchain: Collection {
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    public var startIndex: Int {
        return 0
    }
    
    public var endIndex: Int {
        return blocks.count
    }
    
    /// The last block in the chain.
    public var last: Block<T> {
        // We can force-unwrap here because we know the `blocks` array is never empty
        // and always contains the genesis block.
        return blocks.last!
    }
    
}

// MARK: - CustomStringConvertible

extension Blockchain: CustomStringConvertible {
    
    public var description: String {
        return blocks.map { $0.description }.joined(separator: "\n  |\n  |\n  |\n  |\n")
    }
    
}
