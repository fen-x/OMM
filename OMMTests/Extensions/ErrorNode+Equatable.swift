//
//  ErrorNode+Equatable.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

@testable
import OMM

extension ErrorNode: Equatable { }

func ==(lhs: ErrorNode, rhs: ErrorNode) -> Bool {
    return lhs.error == rhs.error
        && lhs.recoverable == rhs.recoverable
}
