//
//  Cryptography.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/14/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation
import CommonCrypto

extension Data {
    
    /// The SHA256 hash value of the data.
    var hash: Hash {
        var hash = [Byte](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(count), &hash)
        }
        return Data(bytes: hash)
    }
    
}

/// Encapsulates key generation functions.
struct Cryptography {
    
    public enum Error: Swift.Error {
        case privateKeyGenerationFailure
        case publicKeyGenerationFailure
    }
    
    /// Creates a matching pair of a private and a public key.
    ///
    /// - Returns: A tuple of a matching private and public key.
    /// - Throws: A `Cryptography.Error` if the key generation failed.
    static func createKeyPair() throws -> (privateKey: SecKey, publicKey: SecKey) {
        let tag = "wallet.key".data(using: .utf8)!
        
        let privateKeyAttributes: [String: Any] = [
            kSecAttrIsPermanent as String:      false,
            kSecAttrApplicationTag as String:   tag
        ]
        
        let parameters: [String: Any] = [
            kSecAttrKeyType as String:          kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String:    2048,
            kSecPrivateKeyAttrs as String:      privateKeyAttributes
        ]
        
        guard let privateKey = SecKeyCreateRandomKey(parameters as CFDictionary, nil) else {
            throw Error.privateKeyGenerationFailure
        }
        
        guard let publicKey = SecKeyCopyPublicKey(privateKey) else {
            throw Error.publicKeyGenerationFailure
        }
        
        return (privateKey, publicKey)
    }
    
}
