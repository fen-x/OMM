//
//  TransformType.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
protocol TransformType {

    typealias Value

    func applyToNode(node: NodeType) throws -> Value

}

public
extension TransformType {

    func errorWithReason(reason: String) -> ErrorType {
        return TransformError(transformType: Self.self, targetType: Self.Value.self, reason: reason)
    }

}
