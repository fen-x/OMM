//
//  URLTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSURL

public
struct URLTransform: TransformType {

    public
    init() { }

    public
    func applyToNode(node: NodeType) throws -> NSURL {
        guard let URL = try NSURL(string: node.value(String)) else {
            throw errorWithReason("Invalid URL")
        }
        return URL
    }

}
