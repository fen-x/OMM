//
//  Factory.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSNull

/// Creates node with given raw object.
/// - Parameter source: Raw object.
/// - Returns: Node initialized with given source.
public
func NodeForObject(source: AnyObject) -> NodeType {
    return NodeForObject(source, path: [])
}

func NodeForObject(source: AnyObject?, path: [SubscriptKey]) -> NodeType {
    guard let source = source else {
        return ErrorNode(error: UndefinedValueError(), path: path, recoverable: true)
    }
    if source is NSNull {
        return ErrorNode(error: NullValueError(), path: path, recoverable: true)
    }
    return ValueNode(source: source, path: path)
}
