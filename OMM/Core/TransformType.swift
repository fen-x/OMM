//
//  TransformType.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// A type that represents transformation from node to value.
public
protocol TransformType {

    /// Resulting value of transformation.
    typealias Value

    /// Transforms node to value.
    ///
    /// - Parameter node: Node.
    /// - Returns: Result of transformation.
    /// - Throws: Any user thrown errors.
    func applyToNode(node: NodeType) throws -> Value

}

public
extension TransformType {

    /// Creates an instance of `TransformError` initialized with type of `self`, it's resulting value type and given reason.
    ///
    /// - Parameter reason: Explanation of the error reason.
    /// - Returns: Initialized instance of `TransformError`.
    func errorWithReason(reason: String) -> ErrorType {
        return TransformError(transformType: Self.self, targetType: Self.Value.self, reason: reason)
    }

}
