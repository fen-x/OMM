//
//  DateFromSecondsTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Transformation that transforms node to `Date` value
/// in case of date represented as the number of **seconds** that have elapsed since 00:00:00 Coordinated Universal Time (UTC), Thursday, 1 January 1970.
public
struct DateFromSecondsTransform: Transform {

    /// Creates an instance of `DateFromSecondsTransform`.
    public
    init() { }

    /// Transforms node to `Date` value.
    ///
    /// - Parameter node: Node.
    /// - Returns: `Date` instance.
    /// - Throws: `MappingError`.
    public
    func apply(to node: Node) throws -> Date {
        return try Date(timeIntervalSince1970: node.value(TimeInterval.self))
    }

}
