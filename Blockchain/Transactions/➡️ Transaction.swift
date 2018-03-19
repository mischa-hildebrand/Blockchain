//
//  Transaction.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/14/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

public typealias Address = String

/// A `Transaction` represents the transfer of a certain amount of money
/// from the sender's wallet to the receiver's wallet.
public struct Transaction {
    
    // The address of the person or entity sending money.
    public let sender: Address
    
    // The address of the person or entity receiving money.
    public let receiver: Address
    
    // The amount of money being transferred.
    public let amount: Money
    
    public init(sender: Address, receiver: Address, amount: Money) {
        self.sender = sender
        self.receiver = receiver
        self.amount = amount
    }
    
}

extension Transaction: DataConvertible {
    
    public static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.sender == rhs.sender && lhs.receiver == rhs.receiver && lhs.amount == rhs.amount
    }
    
}
