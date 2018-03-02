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
    
    // The wallet of the person or entity sending money.
    let sender: Wallet
    
    // The wallet of the person or entity receiving money.
    let receiver: Wallet
    
    // The amount of money being transferred.
    let amount: Money
    
}

extension Transaction: DataConvertible {
    
    static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.sender == rhs.sender && lhs.receiver == rhs.receiver && lhs.amount == rhs.amount
    }
    
}

struct Money: Equatable {
    let value: Float
    let currency: Currency
    
    static func ==(lhs: Money, rhs: Money) -> Bool {
        return (lhs.value == rhs.value) && (lhs.currency == rhs.currency)
    }
}

struct Currency: Equatable {
    /// The name of the currency, e.g. "Euro" or "Dollar".
    let name: String
    /// The symbol of the currency, e.g. "€" or "$".
    let symbol: Character
    /// The abbreviation for the currency, e.g. "EUR" or "USD".
    let abbreviation: String
    
    static func ==(lhs: Currency, rhs: Currency) -> Bool {
        return lhs.abbreviation == rhs.abbreviation
    }
}

