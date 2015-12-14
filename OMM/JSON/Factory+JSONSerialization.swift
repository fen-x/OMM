//
//  Factory+JSONSerialization.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSData
import class Foundation.NSJSONSerialization

/// Creates node with raw object deserialized from given data using `NSJSONSerialization`.
///
/// - Parameter data: Binary data.
/// - Returns: Node initialized with deserialized given data.
public
func NodeForJSONObjectWithData(data: NSData) -> NodeType {
    return NodeForObject(try NSJSONSerialization.JSONObjectWithData(data, options: []))
}
