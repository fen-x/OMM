//
//  DummySuccessTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import OMM

struct DummySuccessTransform<T>: TransformType {

    let value: T

    func applyToNode(node: NodeType) throws -> T {
        return value
    }

}
