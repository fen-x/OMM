//
//  ValueNode+Equatable.swift
//  OMM
//
//  Created by Ivan Nikitin on 08/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

@testable
import OMM

extension ValueNode: Equatable { }

func ==(lhs: ValueNode, rhs: ValueNode) -> Bool {
    return lhs.source === rhs.source
        && lhs.path == rhs.path
}
