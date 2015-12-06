//
//  NodeType+Mappable.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
extension NodeType {

    /// Gets the `Mappable` instance initialized with `self`.
    /// - Parameter type: `Mappable` type. Defaults to inferred type.
    /// - Returns: The value of `Mappable` type.
    /// - Throws: `MappingError` (true for all inbuilt `NodeType` conformances).
    func value<T: Mappable>(type: T.Type = T.self) throws -> T {
        return try value(transformedWith: MappableTransform())
    }

    /// Gets the array of `Mappable` instances.
    /// - Parameter type: `Mappable` type. Defaults to inferred type.
    /// - Returns: Array of `Mappable` instances.
    /// - Throws: `MappingError` (true for all inbuilt `NodeType` conformances).
    func array<T: Mappable>(type: T.Type = T.self) throws -> [T] {
        return try array().map { try $0.value(type) }
    }

    /// Gets the dictionaty with `String` keys and `Mappable` type values.
    /// - Parameter type: `Mappable` type. Defaults to inferred type.
    /// - Returns: Dictionary with `String` keys and `Mappable` type values.
    /// - Throws: `MappingError` (true for all inbuilt `NodeType` conformances).
    func dictionary<T: Mappable>(type: T.Type = T.self) throws -> [String: T] {
        return try dictionary().toDictionary { try ($0, $1.value(type)) }
    }

}
