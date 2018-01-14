//
//  Wallet.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/14/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

/// An entity to which money can be assigned.
public class Wallet {
    
    public enum Error: Swift.Error {
        case privateKeyGenerationFailure
        case publicKeyGenerationFailure
    }
    
    private let privateKey: SecKey
    public let publicKey: SecKey
    
    public init() {
        guard let keyPair = try? Wallet.createKeyPair() else {
            fatalError("Wallet could not be initialized because the key generation failed.")
        }
        self.publicKey = keyPair.publicKey
        self.privateKey = keyPair.privateKey
    }
    
    private static func createKeyPair() throws -> (privateKey: SecKey, publicKey: SecKey) {
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
