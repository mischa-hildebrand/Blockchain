//
//  Money.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 3/2/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

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

