//
//  Factory+PropertyListSerialization.swift
//  OMM
//
//  Created by Ivan Nikitin on 06/12/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Creates node with raw object deserialized from given data using `PropertyListSerialization`.
///
/// - Parameter data: Binary data.
/// - Returns: Node initialized with deserialized given data.
public
func makeNode(forPropertyList data: Data) -> Node {
    return makeNode(for: try PropertyListSerialization.propertyList(from: data, format: nil))
}
