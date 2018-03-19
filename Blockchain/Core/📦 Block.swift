//
//  Block.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/13/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

public typealias Hash = Data

// MARK: - Block Definition

/// A block that can be attached to a blockchain.
public struct Block<T: DataConvertible> {
    
    /// The information stored in a block, on which the hash is computed.
    public var content: BlockContent<T> {
        didSet {
            hash = content.hash
        }
    }
    
    /// The hash value for this block.
    public var hash: Hash
    
    // MARK: - Initialization
    
    /// Initializer.
    /// Creates a new block with the contents provided, computes the hash for these contents
    /// and stores it in the block's `hash` property.
    ///
    /// - Parameter content: The block contents from which the hash is generated.
    public init(content: BlockContent<T>) {
        self.content = content
        self.hash = content.hash
    }
    
    /// Initializer.
    /// Creates a new block with the contents provided, computes the hash for these contents
    /// and stores it in the block's `hash` property.
    ///
    /// - Parameters:
    ///   - payload: Contains the actual data of the block.
    ///   - previousHash: The previous block's hash value.
    ///   - nonce: A value that can be changed in order to change the hash of this block without changing the block's payload.
    ///   - timestamp: Specifies the point in time when this block was created. (Default value = _now_)
    public init(payload: T?, previousHash: Hash? = nil, nonce: Int = 0, timestamp: Date = Date()) {
        self.init(content:
            BlockContent(
                timestamp: timestamp,
                previousHash: previousHash,
                nonce: nonce,
                payload: payload
            )
        )
    }
}

extension Block: CustomStringConvertible {
    
    public var description: String {
        return "Block {\n" + content.description + "\n" + "hash: \(hash.hexEncodedString())" + "\n}"
    }

}

// MARK: - Block Content

/// Encapsulates all contents of a block over which its hash value is computed.
public struct BlockContent<T: DataConvertible> {
    
    /// Specifies the point in time when this block was created.
    public let timestamp: Date
    
    /// The previous block's hash.
    public let previousHash: Hash?
    
    /// A value that can be changed in order to change the hash of this block
    /// without changing the block's payload.
    public var nonce: Int
    
    /// Contains the actual data of the block.
    /// (Might be transactions, smart contracts or anything you want.)
    public let payload: T?
}

extension BlockContent {
    
    public var hash: Hash {
        return data.hash
    }
    
    public static func ==(lhs: BlockContent, rhs: BlockContent) -> Bool {
        return lhs.timestamp == rhs.timestamp &&
            lhs.previousHash == rhs.previousHash &&
            lhs.payload == rhs.payload &&
            lhs.nonce == rhs.nonce
    }
    
}

extension BlockContent: DataConvertible {
    
    /// A concatenated data representation of the block content.
    public var data: Data {
        var data = Data()
        data.append(timestamp.data)
        if let previousHash = previousHash {
            data.append(previousHash)
        }
        // FIXME: The optional type should be `DataConvertible` so we don't need to unwrap it here.
        //        This will be possible in Swift 4.2 which introduces conditional conformances:
        //        https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md
        if let payload = payload {
            data.append(payload.data)
        }
        data.append(nonce.data)
        return data
    }
    
}

extension BlockContent: CustomStringConvertible {
    
    public var description: String {
        
        var payloadDescription: String {
            if let payload = payload {
                return "\(payload)"
            } else {
                return "–"
            }
        }
        
        var previousHashString: String {
            if let previousHash = previousHash {
                return previousHash.hexEncodedString()
            } else {
                return "–"
            }
        }
        
        return "Content {\n" +
            "    timestamp: \(timestamp)\n" +
            "    previousHash: \(previousHashString)\n" +
            "    nonce: \(nonce)\n" +
            "    payload: \(payloadDescription)\n" +
            " }"
    }
    
}

// MARK: - Convenience Functions

extension Hash {
    
    func beginsWith(numberOfLeadingZeroes: Int) -> Bool {
        for index in 0 ..< numberOfLeadingZeroes {
            if hexDigit(at: index) != 0 {
                return false
            }
        }
        return true
    }
    
}
