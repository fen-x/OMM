//
//  DateFromMillisecondsTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Transformation that transforms node to `Date` value
/// in case of date represented as the number of **milliseconds** that have elapsed since 00:00:00 Coordinated Universal Time (UTC), Thursday, 1 January 1970.
public
struct DateFromMillisecondsTransform: Transform {

    /// Creates an instance of `DateFromMillisecondsTransform`.
    public
    init() { }

    /// Transforms node to `Date` value.
    ///
    /// - Parameter node: Node.
    /// - Returns: `Date` instance.
    /// - Throws: `MappingError`.
    public
    func apply(to node: Node) throws -> Date {
        let number = try node.value(NSNumber.self)
        return Date(timeIntervalSince1970: TimeInterval(number.int64Value) / 1000)
    }
    
}
