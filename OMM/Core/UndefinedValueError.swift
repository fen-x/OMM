//
//  UndefinedValueError.swift
//  OMM
//
//  Created by Ivan Nikitin on 06/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Represents absence of retriving value
/// It means that raw object of node does not exist.
public
struct UndefinedValueError: ErrorType { }

/// `CustomDebugStringConvertible` conformance.
extension UndefinedValueError: CustomDebugStringConvertible {

    /// A textual representation, suitable for debugging.
    public
    var debugDescription: String {
        return "Value is \"undefined\""
    }

}
