//
//  Wallet.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/14/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

/// An entity that can send and receive money.
public class Wallet {
    
    private let privateKey: SecKey
    public let publicKey: SecKey
    
    public init() {
        guard let keyPair = try? Cryptography.createKeyPair() else {
            fatalError("Wallet could not be initialized because the key generation failed.")
        }
        publicKey = keyPair.publicKey
        privateKey = keyPair.privateKey
    }
    
}

extension Wallet: Equatable {
    
    public static func ==(lhs: Wallet, rhs: Wallet) -> Bool {
        return
            lhs.publicKey == rhs.publicKey &&
            lhs.privateKey == rhs.privateKey
    }
    
}
