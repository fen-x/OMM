//
//  ErrorType+Equatable.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
func ==(lhs: ErrorType, rhs: ErrorType) -> Bool {
    if let lhs = lhs as? AnyObject, rhs = rhs as? AnyObject {
        return lhs === rhs
    }
    return lhs._domain == rhs._domain
        && lhs._code == rhs._code
}
