//
//  IntegerTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSNumber

/// Transformation that transforms node to integer value that accessible from `NSNumber` but can not be simply casted or bridged.
public
struct IntegerTransform<T: IntegerType>: TransformType {

    private
    let transform: NSNumber -> T

    private
    init(transform: NSNumber -> T) {
        self.transform = transform
    }

    /// Transforms node to integer value.
    /// - Parameter node: Node.
    /// - Returns: Integer value.
    /// - Throws: `MappingError`.
    public
    func applyToNode(node: NodeType) throws -> T {
        return try transform(node.value(NSNumber))
    }

}

/// Transformation that transforms node to `Int8` value (char value).
public
var Int8Transform: IntegerTransform<Int8> {
    return IntegerTransform { $0.charValue }
}

/// Transformation that transforms node to `Int16` value (short value).
public
var Int16Transform: IntegerTransform<Int16> {
    return IntegerTransform { $0.shortValue }
}

/// Transformation that transforms node to `Int32` value (int value).
public
var Int32Transform: IntegerTransform<Int32> {
    return IntegerTransform { $0.intValue }
}

/// Transformation that transforms node to `Int64` value (long long value).
public
var Int64Transform: IntegerTransform<Int64> {
    return IntegerTransform { $0.longLongValue }
}

/// Transformation that transforms node to `UInt8` value (unsigned char value).
public
var UInt8Transform: IntegerTransform<UInt8> {
    return IntegerTransform { $0.unsignedCharValue }
}

/// Transformation that transforms node to `UInt16` value (unsigned short value).
public
var UInt16Transform: IntegerTransform<UInt16> {
    return IntegerTransform { $0.unsignedShortValue }
}

/// Transformation that transforms node to `UInt32` value (unsigned int value).
public
var UInt32Transform: IntegerTransform<UInt32> {
    return IntegerTransform { $0.unsignedIntValue }
}

/// Transformation that transforms node to `UInt64` value (unsigned long long value).
public
var UInt64Transform: IntegerTransform<UInt64> {
    return IntegerTransform { $0.unsignedLongLongValue }
}
