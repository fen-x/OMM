//
//  DateFromSecondsTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class  Foundation.NSDate
import struct Foundation.NSTimeInterval

public
struct DateFromSecondsTransform: TransformType {

    public
    init() { }

    public
    func applyToNode(node: NodeType) throws -> NSDate {
        return try NSDate(timeIntervalSince1970: node.value(NSTimeInterval))
    }

}
