//
//  Factory+JSONSerialization.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Creates node with raw object deserialized from given data using `JSONSerialization`.
///
/// - Parameter data: Binary data.
/// - Returns: Node initialized with deserialized given data.
public
func jsonNode(for data: Data) -> Node {
    return node(for: try JSONSerialization.jsonObject(with: data))
}
