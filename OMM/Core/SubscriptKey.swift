//
//  SubscriptKey.swift
//  OMM
//
//  Created by Ivan Nikitin on 01/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Key for subscripting nodes with both array indexes and property names.
public
enum SubscriptKey {

    /// Array index.
    case ArrayIndex(Int)

    /// Object property name.
    case ObjectProperty(String)

}

/// `IntegerLiteralConvertible` conformance.
extension SubscriptKey: IntegerLiteralConvertible {

    /// Creates an instance initialized to `ArrayIndex` with associated value.
    ///
    /// - Parameter value: Integer value.
    public
    init(integerLiteral value: Int) {
        self = .ArrayIndex(value)
    }

}

/// `StringLiteralConvertible` conformance.
extension SubscriptKey: StringLiteralConvertible {

    /// Creates an instance initialized to `ObjectProperty` with associated value.
    ///
    /// - Parameter value: String value.
    public
    init(stringLiteral value: String) {
        self = .ObjectProperty(value)
    }

    /// Creates an instance initialized to `ObjectProperty` with associated value.
    ///
    /// - Parameter value: String value.
    public
    init(extendedGraphemeClusterLiteral value: String) {
        self = .ObjectProperty(value)
    }

    /// Creates an instance initialized to `ObjectProperty` with associated value.
    ///
    /// - Parameter value: String value.
    public
    init(unicodeScalarLiteral value: String) {
        self = .ObjectProperty(value)
    }
    
}

/// `CustomDebugStringConvertible` conformance.
extension SubscriptKey: CustomDebugStringConvertible {

    /// A textual representation, suitable for debugging.
    public
    var debugDescription: String {
        switch self {
        case .ArrayIndex(let index):
            return String(index)
        case .ObjectProperty(let property):
            return property
        }
    }

}

/// `Equatable` conformance.
extension SubscriptKey: Equatable { }

/// Compares two `SubscriptKey` instances.
///
/// - Parameter lhs: Left-hand side.
/// - Parameter rhs: Right-hand side.
/// - Returns: `true` if `lhs` is identical `rhs`; otherwise, `false`.
public
func ==(lhs: SubscriptKey, rhs: SubscriptKey) -> Bool {
    switch (lhs, rhs) {
    case (.ArrayIndex(let lhs), .ArrayIndex(let rhs)):
        return lhs == rhs
    case (.ObjectProperty(let lhs), .ObjectProperty(let rhs)):
        return lhs == rhs
    default:
        return false
    }
}
