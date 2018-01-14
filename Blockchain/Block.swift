//
//  Block.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/13/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

/// A block that can be attached to a blockchain.
public struct Block<T> {
    
    /// Specifies the point in time when this block was created.
    public let timestamp: Date
    
    /// The hash value for this block.
    /// Computed from all data included in this block, except the hash itself.
    public let hash: Int
    
    /// The previous block's hash value.
    public let previousHash: Int
    
    /// A value that can be changed in order to change the hash of this block
    /// without changing the block's payload.
    public let nonce: Int
    
    /// Contains the actual data of the block.
    /// (Might be transactions, smart contracts or anything you want.)
    public let payload: T
    
    /// The designated initializer.
    ///
    /// - Parameters:
    ///   - payload: Contains the actual data of the block.
    ///   - hash: The hash value for this block.
    ///   - previousHash: The previous block's hash value.
    ///   - nonce: A value that can be changed in order to change the hash of this block without changing the block's payload.
    ///   - timestamp: Specifies the point in time when this block was created. (Default value = _now_)
    public init(payload: T, hash: Int, previousHash: Int, nonce: Int, timestamp: Date = Date()) {
        self.payload = payload
        self.hash = hash
        self.previousHash = previousHash
        self.nonce = nonce
        self.timestamp = timestamp
    }
    
}
