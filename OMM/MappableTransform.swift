//
//  MappableTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

struct MappableTransform<T: Mappable>: TransformType {

    func applyToNode(node: NodeType) throws -> T {
        return try T(node: node)
    }

}
