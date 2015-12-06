//
//  Factory+PropertyListSerialization.swift
//  OMM
//
//  Created by Ivan Nikitin on 06/12/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSData
import class Foundation.NSPropertyListSerialization

/// Creates node with raw object deserialized from given data using `NSPropertyListSerialization`.
/// - Parameter data: Binary data.
/// - Returns: Node initialized with deserialized given data.
public
func NodeForPropertyListObjectWithData(data: NSData) -> NodeType {
    do {
        let source = try NSPropertyListSerialization.propertyListWithData(data, options: [], format: nil)
        return NodeForObject(source)
    } catch {
        return ErrorNode(error: error, path: [], recoverable: false)
    }
}
