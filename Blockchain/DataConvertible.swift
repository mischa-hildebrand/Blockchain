//
//  DataConvertible.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 1/14/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import Foundation

/// A type that can be converted to a `Data` instance and vice-versa.
public protocol DataConvertible: Equatable {
    
    var data: Data { get }
    
}

extension Date: DataConvertible {
    
    public var data: Data {
        return dataRepresentation(of: self)
    }
    
}

extension Int: DataConvertible {
    
    public var data: Data {
        return dataRepresentation(of: self)
    }
    
}

func dataRepresentation<T>(of source: T) -> Data {
    var sourceCopy = source
    return Data(bytes: &sourceCopy, count: MemoryLayout<T>.size)
}
