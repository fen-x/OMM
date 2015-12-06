//
//  RawRepresentableTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Transformation that transforms node to `RawRepresentable` value.
public
struct RawRepresentableTransform<T: RawRepresentable where T.RawValue: ScalarType>: TransformType {

    private
    let transform = RawRepresentableOptionalTransform<T>()

    /// Creates an instance of `RawRepresentableTransform`.
    public
    init() { }

    /// Transforms node to `RawRepresentable` value.
    /// - Parameter node: Node.
    /// - Returns: `RawRepresentable` instance.
    /// - Throws: `MappingError`, `TransformError` if there is no value represented with raw value of node.
    public
    func applyToNode(node: NodeType) throws -> T {
        guard let value = try transform.applyToNode(node) else {
            throw errorWithReason("Unexpected raw value")
        }
        return value
    }

}
