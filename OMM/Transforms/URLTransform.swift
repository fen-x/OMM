//
//  URLTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSURL

/// Transformation that transforms node to `NSURL` value.
public
struct URLTransform: TransformType {

    /// Creates an instance of `URLTransform`.
    public
    init() { }

    /// Transforms node to `NSURL` value.
    /// - Parameter node: Node.
    /// - Returns: `NSURL` instance.
    /// - Throws: `MappingError`, `TransformError` if `String` value of node does not represent valid URL.
    public
    func applyToNode(node: NodeType) throws -> NSURL {
        guard let URL = try NSURL(string: node.value(String)) else {
            throw errorWithReason("Invalid URL")
        }
        return URL
    }

}
