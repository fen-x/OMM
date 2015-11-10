//
//  MappingError+Equatable.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import OMM

extension MappingError: Equatable { }

public
func ==(lhs: MappingError, rhs: MappingError) -> Bool {
    return lhs.underlyingError == rhs.underlyingError
        && lhs.path == rhs.path
}

private
func ==(lhs: ErrorType, rhs: ErrorType) -> Bool {
    if let lhs = lhs as? DummyError, rhs = rhs as? DummyError {
        return lhs === rhs
    }
    if lhs is UndefinedValueError && rhs is UndefinedValueError {
        return true
    }
    if lhs is NullValueError && rhs is NullValueError {
        return true
    }
    if let lhs = lhs as? UnexpectedTypeError, rhs = rhs as? UnexpectedTypeError {
        return lhs.expectedType == rhs.expectedType
            && lhs.actualType == rhs.actualType
    }
    fatalError("Unknown error type.")
}
