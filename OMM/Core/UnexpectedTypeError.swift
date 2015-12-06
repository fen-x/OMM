//
//  UnexpectedTypeError.swift
//  OMM
//
//  Created by Ivan Nikitin on 06/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Represents the situation when raw object could not be casted or bridget to an expected type.
public
struct UnexpectedTypeError: ErrorType {

    /// Expected type necessary to complete requested operation.
    public
    let expectedType: Any.Type

    /// Actual type of raw object.
    public
    let actualType: Any.Type
    
}

/// `CustomDebugStringConvertible` conformance.
extension UnexpectedTypeError: CustomDebugStringConvertible {

    /// A textual representation, suitable for debugging.
    public
    var debugDescription: String {
        return "\"\(expectedType)\" is expected but \"\(actualType)\" found"
    }

}
