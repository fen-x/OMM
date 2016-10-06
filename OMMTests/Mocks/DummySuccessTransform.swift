//
//  DummySuccessTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import OMM

struct DummySuccessTransform<T>: Transform {

    let value: T

    func apply(to node: Node) throws -> T {
        return value
    }

}
