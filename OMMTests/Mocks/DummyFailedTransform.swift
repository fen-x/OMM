//
//  DummyFailedTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import OMM

struct DummyFailedTransform<T: Error>: Transform {

    let error: T

    func apply(to node: Node) throws -> Any {
        throw error
    }
    
}
