//
//  Transaction.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/14/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

/// A `Transaction` transfers a certain amount of money
/// from the sender's wallet to the receiver's wallet.
struct Transaction {
    
    // The wallet of the person or entity sending money.
    let sender: Wallet
    
    // The wallet of the person or entity receiving money.
    let receiver: Wallet
    
    // The amount of money being transferred.
    let amount: Money
    
}

protocol Money {
    var value: Float { get }
    var currency: Currency { get }
}

protocol Currency {
    var symbol: Character { get }
    var abbreviation: String { get }
}

struct Crypto€: Currency {
    var symbol: Character = "€"
    var abbreviation: String = "KEU"
}
