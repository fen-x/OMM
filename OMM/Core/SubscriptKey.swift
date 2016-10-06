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
    case arrayIndex(Int)

    /// Object property name.
    case objectProperty(String)

}

/// `IntegerLiteralConvertible` conformance.
extension SubscriptKey: ExpressibleByIntegerLiteral {

    /// Creates an instance initialized to `ArrayIndex` with associated value.
    ///
    /// - Parameter value: Integer value.
    public
    init(integerLiteral value: Int) {
        self = .arrayIndex(value)
    }

}

/// `StringLiteralConvertible` conformance.
extension SubscriptKey: ExpressibleByStringLiteral {

    /// Creates an instance initialized to `ObjectProperty` with associated value.
    ///
    /// - Parameter value: String value.
    public
    init(stringLiteral value: String) {
        self = .objectProperty(value)
    }

    /// Creates an instance initialized to `ObjectProperty` with associated value.
    ///
    /// - Parameter value: String value.
    public
    init(extendedGraphemeClusterLiteral value: String) {
        self = .objectProperty(value)
    }

    /// Creates an instance initialized to `ObjectProperty` with associated value.
    ///
    /// - Parameter value: String value.
    public
    init(unicodeScalarLiteral value: String) {
        self = .objectProperty(value)
    }
    
}

/// `CustomDebugStringConvertible` conformance.
extension SubscriptKey: CustomDebugStringConvertible {

    /// A textual representation, suitable for debugging.
    public
    var debugDescription: String {
        switch self {
        case .arrayIndex(let index):
            return String(index)
        case .objectProperty(let property):
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
    case (.arrayIndex(let lhs), .arrayIndex(let rhs)):
        return lhs == rhs
    case (.objectProperty(let lhs), .objectProperty(let rhs)):
        return lhs == rhs
    default:
        return false
    }
}
