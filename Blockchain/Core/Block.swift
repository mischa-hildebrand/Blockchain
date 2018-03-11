//
//  Block.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/13/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

public typealias Hash = Int

/// A block that can be attached to a blockchain.
public struct Block<T: DataConvertible> {
    
    /// The information stored in a block, on which the hash is computed.
    public var content: Content
    
    /// The hash value for this block.
    /// Computed from the block's `content`.
    public var hash: Int
    
}

extension Block {
    
    /// Initializer.
    /// Creates a new block with the contents provided, computes the hash for these contents
    /// and stores it in the block's `hash` property.
    ///
    /// - Parameters:
    ///   - payload: Contains the actual data of the block.
    ///   - previousHash: The previous block's hash value.
    ///   - nonce: A value that can be changed in order to change the hash of this block without changing the block's payload.
    ///   - timestamp: Specifies the point in time when this block was created. (Default value = _now_)
    public init(payload: T, previousHash: Int, nonce: Int, timestamp: Date = Date()) {
        self.init(content:
            Content(
                timestamp: timestamp,
                previousHash: previousHash,
                nonce: nonce,
                payload: payload
            )
        )
    }
    
    /// Initializer.
    /// Creates a new block with the contents provided, computes the hash for these contents
    /// and stores it in the block's `hash` property.
    ///
    /// - Parameter content: The block contents from which the hash is generated.
    public init(content: Content) {
        self.content = content
        self.hash = content.hashValue
    }
    
}

public extension Block {
    
    /// Encapsulates all contents of a block, except its hash value.
    public struct Content {
        
        /// Specifies the point in time when this block was created.
        public let timestamp: Date
        
        /// The previous block's hash value.
        public let previousHash: Int
        
        /// A value that can be changed in order to change the hash of this block
        /// without changing the block's payload.
        public var nonce: Int
        
        /// Contains the actual data of the block.
        /// (Might be transactions, smart contracts or anything you want.)
        public let payload: T
    }
    
}

extension Block.Content: Hashable {
    
    public var hashValue: Hash {
        let hashData = data.hash // The hash as `Data`.
        let hashValue: Int = hashData.withUnsafeBytes { $0.pointee } // The hash as `Int`.
        return hashValue
    }
    
    public static func ==(lhs: Block<T>.Content, rhs: Block<T>.Content) -> Bool {
        return lhs.timestamp == rhs.timestamp &&
            lhs.previousHash == rhs.previousHash &&
            lhs.payload == rhs.payload &&
            lhs.nonce == rhs.nonce
        
    }
    
}

extension Block.Content: DataConvertible {
    
    public var data: Data {
        var data = Data()
        data.append(timestamp.data)
        data.append(previousHash.data)
        data.append(payload.data)
        data.append(nonce.data)
        return data
    }
    
}

extension Hash {
    
    func beginsWith(numberOfLeadingZeroes: Int) -> Bool {
        return numberOfLeadingZeroes >= leadingZeroBitCount
    }
    
}
