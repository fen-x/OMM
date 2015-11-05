//
//  UndefinedValueError.swift
//  OMM
//
//  Created by Ivan Nikitin on 06/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
struct UndefinedValueError: ErrorType { }

extension UndefinedValueError: CustomDebugStringConvertible {

    public
    var debugDescription: String {
        return "Value is \"undefined\""
    }

}
