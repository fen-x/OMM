//
//  MappableTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

struct MappableTransform<T: Mappable>: Transform {

    func apply(to node: Node) throws -> T {
        return try T(node: node)
    }

}
