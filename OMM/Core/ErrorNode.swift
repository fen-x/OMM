//
//  ErrorNode.swift
//  OMM
//
//  Created by Ivan Nikitin on 03/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

struct ErrorNode: NodeType {

    let error: MappingError
    let recoverable: Bool

    subscript(key: SubscriptKey) -> NodeType {
        return self
    }

    var optional: NodeType? {
        return recoverable ? nil : self
    }

    func array() throws -> [NodeType] {
        throw error
    }

    func dictionary() throws -> [String: NodeType] {
        throw error
    }

    func value<T: ScalarType>() throws -> T {
        throw error
    }

}
