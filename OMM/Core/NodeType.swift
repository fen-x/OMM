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

    func value<T: ScalarType>() throws -> T
    
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
