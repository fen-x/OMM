//
//  NodeType+Mappable.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
extension NodeType {

    func value<T: Mappable>(type: T.Type) throws -> T {
        return try value(transformedWith: MappableTransform())
    }

    func array<T: Mappable>(type: T.Type) throws -> [T] {
        return try array().map { try $0.value(type) }
    }

    func dictionary<T: Mappable>(type: T.Type) throws -> [String: T] {
        return try dictionary().toDictionary { try ($0, $1.value(type)) }
    }

}
