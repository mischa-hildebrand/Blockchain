//
//  Block.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/13/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

public typealias Hash = Int

// MARK: - Block Definition

/// A block that can be attached to a blockchain.
public struct Block<T: DataConvertible> {
    
    /// The information stored in a block, on which the hash is computed.
    public var content: BlockContent<T>
    
    /// The hash value for this block.
    /// Computed from the block's `content`.
    public var hash: Int {
        return content.hashValue
    }
    
    // MARK: - Initialization
    
    /// Initializer.
    /// Creates a new block with the contents provided, computes the hash for these contents
    /// and stores it in the block's `hash` property.
    ///
    /// - Parameter content: The block contents from which the hash is generated.
    public init(content: BlockContent<T>) {
        self.content = content
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
    public init(payload: T?, previousHash: Int = 0, nonce: Int = 0, timestamp: Date = Date()) {
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
        return content.description + "\n" + "hash: \(hash)"
    }

}

// MARK: - Block Content

/// Encapsulates all contents of a block over which its hash value is computed.
public struct BlockContent<T: DataConvertible> {
    
    /// Specifies the point in time when this block was created.
    public let timestamp: Date
    
    /// The previous block's hash value.
    public let previousHash: Int
    
    /// A value that can be changed in order to change the hash of this block
    /// without changing the block's payload.
    public var nonce: Int
    
    /// Contains the actual data of the block.
    /// (Might be transactions, smart contracts or anything you want.)
    public let payload: T?
}

extension BlockContent: Hashable {
    
    public var hashValue: Hash {
        let hashData = data.hash // The hash as `Data`.
        let hashValue: Int = hashData.withUnsafeBytes { $0.pointee } // The hash as `Int`.
        return hashValue
    }
    
    public static func ==(lhs: BlockContent, rhs: BlockContent) -> Bool {
        return lhs.timestamp == rhs.timestamp &&
            lhs.previousHash == rhs.previousHash &&
            lhs.payload == rhs.payload &&
            lhs.nonce == rhs.nonce
    }
    
}

extension BlockContent: DataConvertible {
    
    public var data: Data {
        var data = Data()
        data.append(timestamp.data)
        data.append(previousHash.data)
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
        let payloadDescription: String
        if let payload = payload {
            payloadDescription = "\(payload)"
        } else {
            payloadDescription = "[empty payload]"
        }
        
        return "Block {\n" +
            "    timestamp: \(timestamp)\n" +
            "    previousHash: \(previousHash)\n" +
            "    nonce: \(nonce)\n" +
            "    payload: \(payloadDescription)\n" +
            " }"
    }
    
}

// MARK: - Convenience Functions

extension Hash {
    
    func beginsWith(numberOfLeadingZeroes: Int) -> Bool {
        return leadingZeroBitCount >= numberOfLeadingZeroes
    }
    
}
