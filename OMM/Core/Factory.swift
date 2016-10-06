//
//  Factory.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Creates node with given raw object.
///
/// - Parameter source: Raw object.
/// - Returns: Node initialized with given source.
public
func node(for source: @autoclosure () throws -> Any) -> Node {
    do {
        return try node(for: source(), at: [])
    } catch {
        return ErrorNode(error: error, path: [], recoverable: false)
    }
}

func node(for source: Any?, at path: [SubscriptKey]) -> Node {
    guard let source = source else {
        return ErrorNode(error: UndefinedValueError(), path: path, recoverable: true)
    }
    if source is NSNull {
        return ErrorNode(error: NullValueError(), path: path, recoverable: true)
    }
    return ValueNode(source: source, path: path)
}
