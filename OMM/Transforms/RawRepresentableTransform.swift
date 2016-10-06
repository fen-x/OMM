//
//  RawRepresentableTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Transformation that transforms node to `RawRepresentable` value.
public
struct RawRepresentableTransform<T: RawRepresentable>: Transform where T.RawValue: Scalar {

    private
    let transform = RawRepresentableOptionalTransform<T>()

    /// Creates an instance of `RawRepresentableTransform`.
    public
    init() { }

    /// Transforms node to `RawRepresentable` value.
    ///
    /// - Parameter node: Node.
    /// - Returns: `RawRepresentable` instance.
    /// - Throws: `MappingError`, `TransformError` if there is no value represented with raw value of node.
    public
    func apply(to node: Node) throws -> T {
        guard let value = try transform.apply(to: node) else {
            throw error(reason: "Unexpected raw value")
        }
        return value
    }

}
