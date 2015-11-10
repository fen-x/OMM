//
//  DateFromMillisecondsTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class  Foundation.NSDate
import class  Foundation.NSNumber
import struct Foundation.NSTimeInterval

public
struct DateFromMillisecondsTransform: TransformType {

    public
    init() { }

    public
    func applyToNode(node: NodeType) throws -> NSDate {
        let number = try node.value(NSNumber)
        return NSDate(timeIntervalSince1970: NSTimeInterval(number.longLongValue) / 1000)
    }
    
}
