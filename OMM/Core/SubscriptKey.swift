//
//  SubscriptKey.swift
//  OMM
//
//  Created by Ivan Nikitin on 01/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
enum SubscriptKey {

    case ArrayIndex(Int)
    case ObjectProperty(String)

}

extension SubscriptKey: IntegerLiteralConvertible {

    public
    init(integerLiteral value: Int) {
        self = .ArrayIndex(value)
    }

}

extension SubscriptKey: StringLiteralConvertible {

    public
    init(stringLiteral value: String) {
        self = .ObjectProperty(value)
    }

    public
    init(extendedGraphemeClusterLiteral value: String) {
        self = .ObjectProperty(value)
    }

    public
    init(unicodeScalarLiteral value: String) {
        self = .ObjectProperty(value)
    }
    
}

extension SubscriptKey: CustomDebugStringConvertible {

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

extension SubscriptKey: Equatable { }

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
