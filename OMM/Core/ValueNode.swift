//
//  ValueNode.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

struct ValueNode: Node {

    let source: Any
    let path: [SubscriptKey]

    subscript(key: SubscriptKey) -> Node {
        do {
            return try node(for: subsource(at: key), at: path + [key])
        } catch {
            return ErrorNode(error: error, path: path, recoverable: false)
        }
    }

    var optional: Node? {
        return self
    }

    func array() throws -> [Node] {
        let array = try castedSource() as [Any]
        return array.indices.map { self[.arrayIndex($0)] }
    }

    func dictionary() throws -> [String: Node] {
        let dictionary = try castedSource() as [String: Any]
        return dictionary.keys.toDictionary { ($0, self[.objectProperty($0)]) }
    }

    func value<T: Scalar>(_ type: T.Type) throws -> T {
        return try castedSource()
    }

    func value<T: Transform>(transformedWith transform: T) throws -> T.Value {
        do {
            return try transform.apply(to: self)
        } catch let error as MappingError {
            throw error
        } catch {
            throw MappingError(underlyingError: error, path: path)
        }
    }

    private
    func subsource(at key: SubscriptKey) throws -> Any? {
        switch key {
        case .arrayIndex(let index):
            let array = try cast(source) as [Any]
            return array.indices.contains(index) ? array[index] : nil
        case .objectProperty(let property):
            let object = try cast(source) as [String: Any]
            return object[property]
        }
    }

    private
    func castedSource<T>() throws -> T {
        do {
            return try cast(source)
        } catch {
            throw MappingError(underlyingError: error, path: path)
        }
    }

}

private
func cast<T>(_ value: Any) throws -> T {
    guard let result = value as? T else {
        throw UnexpectedTypeError(expectedType: T.self, actualType: type(of: value))
    }
    return result
}
