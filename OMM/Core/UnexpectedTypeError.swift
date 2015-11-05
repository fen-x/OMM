//
//  UnexpectedTypeError.swift
//  OMM
//
//  Created by Ivan Nikitin on 06/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
struct UnexpectedTypeError: ErrorType {

    public
    let expectedType: Any.Type

    public
    let actualType: Any.Type
    
}

extension UnexpectedTypeError: CustomDebugStringConvertible {

    public
    var debugDescription: String {
        return "\"\(expectedType)\" is expected but \"\(actualType)\" found"
    }

}
