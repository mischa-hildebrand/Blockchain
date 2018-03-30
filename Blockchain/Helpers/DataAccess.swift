//
//  DataAccess.swift
//  Blockchain
//
//  Created by Mischa (Privat) on 3/18/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

typealias Byte = Data.Element

struct HexDigit {
    static let bitWidth = 4
    
    static var largestValue: Int {
        let bitWidth = Float(self.bitWidth)
        let two = Float(2)
        let bitCombinationsCount = pow(two, bitWidth)
        return Int(bitCombinationsCount - 1)
    }
}

extension Byte {
    
    /// Returns the bit at the specified index.
    ///
    /// - Parameter index: The index of the bit of interest.
    /// - Returns: `true` if the bit at the specified position is 1, eles `false`.
    func bit(at index: Int) -> Bool {
        guard index < Byte.bitWidth else {
            fatalError("Index out of bounds! A byte has only \(Byte.bitWidth) bits.")
        }
        let singleBit: Data.Element = 1
        let bitmask = singleBit << index
        let sum = self & bitmask
        return sum != 0
    }
    
    /// Interpretes the byte as a string of hex digits
    /// and returns the hex digit at the specified `index` as an integer.
    ///
    /// - Parameter index: The position of the hex digit within the hex digit string.
    /// - Returns: The value of the hex digit as an integer.
    func hexDigit(at index: Int) -> Int {
        let maxIndex = Byte.bitWidth / HexDigit.bitWidth - 1
        guard index <= maxIndex else {
            fatalError("Index out of bounds! Tried to access a hex digit at an index " +
                "that's beyond the limit of this byte. " +
                "(A byte consists of \(Byte.bitWidth / HexDigit.bitWidth) hex digits.")
        }
        
        // e.g. nibble = 0x00001111
        let nibble: Data.Element = UInt8(HexDigit.largestValue)
        // the number of times we have to shift the nibble "1111" to the left
        let nibbleShiftCount = maxIndex - index
        // the number of bits by which we shift
        let shiftBits = nibbleShiftCount * HexDigit.bitWidth
        // e.g. bitmask = 0x00001111 or 0x11110000
        let bitmask = nibble << shiftBits
        let sum = self & bitmask
        // shift it back
        let shiftedSum = sum >> shiftBits
        return Int(shiftedSum)
    }
    
}

extension Data {
    
    /// Interpretes the data as a string of bits
    /// and returns the bit at the specified `index` as a Boolean.
    ///
    /// - Parameter index: The index of the bit within the data bit string.
    /// - Returns: `true` if the bit at the specified position is 1, eles `false`.
    func bit(at index: Int) -> Bool {
        let totalByteSize = count
        guard index < totalByteSize else {
            fatalError("Index out of bounds! Tried to access the byte at index \(index) " +
                "but this data instance has only \(totalByteSize) bytes.")
        }
        let byteSize = Element.bitWidth
        let byteIndex = index / byteSize
        let bitIndex = index % byteSize
        let byte = self[byteIndex]
        return byte.bit(at: bitIndex)
    }
    
    /// Interpretes the data as a string of hex digits
    /// and returns the hex digit at the specified `index` as an integer.
    ///
    /// - Parameter index: The position of the hex digit within the hex digit string.
    /// - Returns: The value of the hex digit as an integer.
    func hexDigit(at index: Int) -> Int {
        let numbersPerByteCount = Element.bitWidth / HexDigit.bitWidth
        let totalNumberCount = count * numbersPerByteCount
        guard index < totalNumberCount else {
            fatalError("Index out of bounds! Tried to access hex number at index \(index) " +
                "but this data instance has only \(totalNumberCount) hex numbers.")
        }
        let byteIndex = index / numbersPerByteCount
        let numberIndex = index % numbersPerByteCount
        return self[byteIndex].hexDigit(at: numberIndex)
    }
    
    /// Transforms the data into its hexadecimal string representation.
    ///
    /// - Returns: A hexadecimal string representing the data.
    func hexEncodedString() -> String {
        let hexDigits = Array("0123456789abcdef".utf16)
        var chars: [unichar] = []
        chars.reserveCapacity(2 * count)
        for byte in self {
            chars.append(hexDigits[Int(byte / 16)])
            chars.append(hexDigits[Int(byte % 16)])
        }
        return String(utf16CodeUnits: chars, count: chars.count)
    }
    
}
