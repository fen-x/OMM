//
//  URLTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Transformation that transforms node to `URL` value.
public
struct URLTransform: Transform {

    /// Creates an instance of `URLTransform`.
    public
    init() { }

    /// Transforms node to `NSURL` value.
    ///
    /// - Parameter node: Node.
    /// - Returns: `NSURL` instance.
    /// - Throws: `MappingError`, `TransformError` if `String` value of node does not represent valid URL.
    public
    func apply(to node: Node) throws -> URL {
        guard let URL = try URL(string: node.value(String.self)) else {
            throw error(reason: "Invalid URL")
        }
        return URL
    }

}
