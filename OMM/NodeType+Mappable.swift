//
//  NodeType+Mappable.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
extension NodeType {

    func value<T: Mappable>() throws -> T {
        return try value(transformedWith: MappableTransform())
    }
}
