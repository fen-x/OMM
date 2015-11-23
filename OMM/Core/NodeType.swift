//
//  NodeType.swift
//  OMM
//
//  Created by Ivan Nikitin on 03/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
protocol NodeType {

    subscript(key: SubscriptKey) -> NodeType { get }

    var optional: NodeType? { get }

    func array() throws -> [NodeType]

    func dictionary() throws -> [String: NodeType]

    func value<T: ScalarType>(type: T.Type) throws -> T

    func value<T: TransformType>(transformedWith transform: T) throws -> T.Value

}

public
extension NodeType {

    subscript(path: SubscriptKey...) -> NodeType {
        return self[path]
    }

    subscript(path: [SubscriptKey]) -> NodeType {
        return path.reduce(self) { $0[$1] }
    }
    
}

public
extension NodeType {

    var required: NodeType {
        return self
    }
    
}

public
extension NodeType {

    func array<T: ScalarType>(type: T.Type) throws -> [T] {
        return try array().map { try $0.value(type) }
    }

    func array<T: TransformType>(transformedWith transform: T) throws -> [T.Value] {
        return try array().map { try $0.value(transformedWith: transform) }
    }

    func dictionary<T: ScalarType>(type: T.Type) throws -> [String: T] {
        return try dictionary().toDictionary { try ($0, $1.value(type)) }
    }

    func dictionary<T: TransformType>(transformedWith transform: T) throws -> [String: T.Value] {
        return try dictionary().toDictionary { try ($0, $1.value(transformedWith: transform)) }
    }

}
