//
//  ErrorNode.swift
//  OMM
//
//  Created by Ivan Nikitin on 03/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

struct ErrorNode: Node {

    let error: MappingError
    let recoverable: Bool

    subscript(key: SubscriptKey) -> Node {
        return self
    }

    var optional: Node? {
        return recoverable ? nil : self
    }

    func array() throws -> [Node] {
        throw error
    }

    func dictionary() throws -> [String: Node] {
        throw error
    }

    func value<T: Scalar>(_ type: T.Type) throws -> T {
        throw error
    }

    func value<T: Transform>(transformedWith transform: T) throws -> T.Value {
        throw error
    }

}

extension ErrorNode {

    init(error: Error, path: [SubscriptKey], recoverable: Bool) {
        self.init(
            error: MappingError(
                underlyingError: error,
                path: path
            ),
            recoverable: recoverable
        )
    }

}
