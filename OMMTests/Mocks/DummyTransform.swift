//
//  DummyTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import OMM

struct DummyTransform: Transform {

    func apply(to node: Node) throws -> Any {
        fatalError("Transform not implemented")
    }

}
