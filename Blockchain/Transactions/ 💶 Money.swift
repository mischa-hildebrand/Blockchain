//
//  Money.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 3/2/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

public struct Money: Equatable {
    public let value: Float
    public let currency: Currency
    
    public init(value: Float, currency: Currency) {
        self.value = value
        self.currency = currency
    }
    
    public static func ==(lhs: Money, rhs: Money) -> Bool {
        return (lhs.value == rhs.value) && (lhs.currency == rhs.currency)
    }
}

public struct Currency: Equatable {
    /// The name of the currency, e.g. "Euro" or "Dollar".
    public let name: String
    /// The symbol of the currency, e.g. "€" or "$".
    public let symbol: Character
    /// The abbreviation for the currency, e.g. "EUR" or "USD".
    public let abbreviation: String
    
    public init(name: String, symbol: Character, abbreviation: String) {
        self.name = name
        self.symbol = symbol
        self.abbreviation = abbreviation
    }
    
    public static func ==(lhs: Currency, rhs: Currency) -> Bool {
        return lhs.abbreviation == rhs.abbreviation
    }
}

