//
//  Transaction.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/14/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

/// A `Transaction` represents the transfer of a certain amount of money
/// from the sender's wallet to the receiver's wallet.
struct Transaction {
    
    // The address of the person or entity sending money.
    let sender: Address
    
    // The address of the person or entity receiving money.
    let receiver: Address
    
    // The amount of money being transferred.
    let amount: Money
    
}

extension Transaction: DataConvertible {
    
    static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.sender == rhs.sender && lhs.receiver == rhs.receiver && lhs.amount == rhs.amount
    }
    
}
