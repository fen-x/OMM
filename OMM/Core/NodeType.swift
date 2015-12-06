//
//  NodeType.swift
//  OMM
//
//  Created by Ivan Nikitin on 03/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// A type that represents value.
public
protocol NodeType {

    /// Gets node from `self` with given key.
    /// - Parameter key: Key to get node.
    /// - Returns: Node gotten with key.
    subscript(key: SubscriptKey) -> NodeType { get }

    /// Returns `nil` if `self` does not contain value; otherwise, `self`.
    var optional: NodeType? { get }

    /// Gets the value of node as an array of nodes.
    /// - Returns: Value of node as an array.
    /// - Throws: `MappingError` (true for all inbuilt `NodeType` conformaces).
    func array() throws -> [NodeType]

    /// Gets the value of node as a dictionaty with `String` keys and node values.
    /// - Returns: Value of node as a dictionary.
    /// - Throws: `MappingError` (true for all inbuilt `NodeType` conformaces).
    func dictionary() throws -> [String: NodeType]

    /// Gets the scalar value of node casted or bridged from raw object.
    /// - Parameter type: Type of value.
    /// - Returns: The value of scalar type.
    /// - Throws: `MappingError` (true for all inbuilt `NodeType` conformaces).
    func value<T: ScalarType>(type: T.Type) throws -> T

    /// Gets the value of node transformed with specified transformation.
    /// - Parameter transform: Transfromation to apply.
    /// - Returns: Result of transformation applied to `self`.
    /// - Throws: `MappingError` (true for all inbuilt `NodeType` conformaces).
    func value<T: TransformType>(transformedWith transform: T) throws -> T.Value

}

public
extension NodeType {

    /// Gets node from `self` with given sequence of keys.
    /// - Parameter path: Sequence of keys.
    /// - Returns: Node gotten with path.
    subscript(path: SubscriptKey...) -> NodeType {
        return self[path]
    }

    /// Gets node from `self` with given array of keys.
    /// - Parameter path: Array of keys.
    /// - Returns: Node gotten with path.
    subscript(path: [SubscriptKey]) -> NodeType {
        return path.reduce(self) { $0[$1] }
    }
    
}

public
extension NodeType {

    /// Returns `self`.
    /// Helps to make clear intent.
    ///
    ///     node.optional?.value(Int)
    ///     node.required.value(Int)
    var required: NodeType {
        return self
    }
    
}

public
extension NodeType {

    /// Gets the scalar value of node casted or bridged from raw object.
    /// - Parameter type: Type of the value. Defaults to inferred type.
    /// - Returns: The value of scalar type.
    /// - Throws: `MappingError` (true for all inbuilt `NodeType` conformances).
    func value<T: ScalarType>(type: T.Type = T.self) throws -> T {
        return try value(type)
    }

    /// Gets the array of scalar values.
    /// - Parameter type: Type of the values. Defaults to inferred type.
    /// - Returns: Array of the scalar type values.
    /// - Throws: `MappingError` (true for all inbuilt `NodeType` conformances).
    func array<T: ScalarType>(type: T.Type = T.self) throws -> [T] {
        return try array().map { try $0.value(type) }
    }

    /// Gets the array of values transformed with specified transformation.
    /// - Parameter transform: Transfromation to apply.
    /// - Returns: Array of values transformed with transformation.
    /// - Throws: `MappingError` (true for all inbuilt `NodeType` conformances).
    func array<T: TransformType>(transformedWith transform: T) throws -> [T.Value] {
        return try array().map { try $0.value(transformedWith: transform) }
    }

    /// Gets the dictionaty with `String` keys and scalar values.
    /// - Parameter type: Type of the values. Defaults to inferred type.
    /// - Returns: Dictionary with `String` keys and scalar values.
    /// - Throws: `MappingError` (true for all inbuilt `NodeType` conformances).
    func dictionary<T: ScalarType>(type: T.Type = T.self) throws -> [String: T] {
        return try dictionary().toDictionary { try ($0, $1.value(type)) }
    }

    /// Gets the dictionaty with `String` keys and values transformed with specified transformation.
    /// - Parameter transform: Transfromation to apply.
    /// - Returns: Dictionary with `String` keys and values transformed with transformation.
    /// - Throws: `MappingError` (true for all inbuilt `NodeType` conformances).
    func dictionary<T: TransformType>(transformedWith transform: T) throws -> [String: T.Value] {
        return try dictionary().toDictionary { try ($0, $1.value(transformedWith: transform)) }
    }

}
