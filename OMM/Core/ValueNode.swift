//
//  ValueNode.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

struct ValueNode: NodeType {

    let source: AnyObject
    let path: [SubscriptKey]

    subscript(key: SubscriptKey) -> NodeType {
        do {
            return try NodeForObject(sourceForKey(key), path: path + [key])
        } catch {
            return ErrorNode(error: error, path: path, recoverable: false)
        }
    }

    var optional: NodeType? {
        return self
    }

    func array() throws -> [NodeType] {
        let array = try castedSource() as [AnyObject]
        return array.range.map { self[.ArrayIndex($0)] }
    }

    func dictionary() throws -> [String: NodeType] {
        let dictionary = try castedSource() as [String: AnyObject]
        return dictionary.keys.toDictionary { ($0, self[.ObjectProperty($0)]) }
    }

    func value<T: ScalarType>() throws -> T {
        return try castedSource()
    }

    private
    func sourceForKey(key: SubscriptKey) throws -> AnyObject? {
        switch key {
        case .ArrayIndex(let index):
            let array = try cast(source) as [AnyObject]
            return array.valueForIndex(index)
        case .ObjectProperty(let property):
            let object = try cast(source) as [String: AnyObject]
            return object[property]
        }
    }

    private
    func castedSource<T>() throws -> T {
        do {
            return try cast(source)
        } catch let error as MappingError {
            throw error
        } catch {
            throw MappingError(underlyingError: error, path: path)
        }
    }

}

private
func cast<T>(value: AnyObject) throws -> T {
    guard let result = value as? T else {
        throw UnexpectedTypeError(expectedType: T.self, actualType: value.dynamicType)
    }
    return result
}
