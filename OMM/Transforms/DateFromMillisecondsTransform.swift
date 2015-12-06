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

/// Transformation that transforms node to `NSDate` value
/// in case of date represented as the number of **milliseconds** that have elapsed since 00:00:00 Coordinated Universal Time (UTC), Thursday, 1 January 1970.
public
struct DateFromMillisecondsTransform: TransformType {

    /// Creates an instance of `DateFromMillisecondsTransform`.
    public
    init() { }

    /// Transforms node to `NSDate` value.
    /// - Parameter node: Node.
    /// - Returns: `NSDate` instance.
    /// - Throws: `MappingError`.
    public
    func applyToNode(node: NodeType) throws -> NSDate {
        let number = try node.value(NSNumber)
        return NSDate(timeIntervalSince1970: NSTimeInterval(number.longLongValue) / 1000)
    }
    
}
