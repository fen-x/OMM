//
//  DummyFailedTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import OMM

struct DummyFailedTransform<T: ErrorType>: TransformType {

    let error: T

    func applyToNode(node: NodeType) throws -> Any {
        throw error
    }
    
}
