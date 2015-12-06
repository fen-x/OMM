//
//  Mappable.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Conforming types can be initialized with node.
public
protocol Mappable {

    /// Create an instance initialized with node.
    /// - Parameter node: Node.
    /// - Throws: Any user thrown errors.
    init(node: NodeType) throws

}
