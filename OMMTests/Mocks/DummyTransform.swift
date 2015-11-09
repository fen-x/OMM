//
//  DummyTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import OMM

struct DummyTransform: TransformType {

    func applyToNode(node: NodeType) throws -> Any {
        fatalError("Transform not implemented")
    }

}
