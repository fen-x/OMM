//
//  Factory+JSONSerialization.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSData
import class Foundation.NSJSONSerialization

public
func NodeForJSONObjectWithData(data: NSData) -> NodeType {
    do {
        let source = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        return NodeForObject(source)
    } catch {
        return ErrorNode(error: error, path: [], recoverable: false)
    }
}
