//
//  IntegerTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Transformation that transforms node to integer value that accessible from `NSNumber` but can not be simply casted or bridged.
public
struct IntegerTransform<T: BinaryInteger>: Transform {

    private
    let keyPath: KeyPath<NSNumber, T>

    fileprivate
    init(keyPath: KeyPath<NSNumber, T>) {
        self.keyPath = keyPath
    }

    /// Transforms node to integer value.
    ///
    /// - Parameter node: Node.
    /// - Returns: Integer value.
    /// - Throws: `MappingError`.
    public
    func apply(to node: Node) throws -> T {
        return try node.value(NSNumber.self)[keyPath: keyPath]
    }

}

/// Transformation that transforms node to `Int8` value (char value).
public
var int8Transform: IntegerTransform<Int8> {
    return IntegerTransform(keyPath: \.int8Value)
}

/// Transformation that transforms node to `Int16` value (short value).
public
var int16Transform: IntegerTransform<Int16> {
    return IntegerTransform(keyPath: \.int16Value)
}

/// Transformation that transforms node to `Int32` value (int value).
public
var int32Transform: IntegerTransform<Int32> {
    return IntegerTransform(keyPath: \.int32Value)
}

/// Transformation that transforms node to `Int64` value (long long value).
public
var int64Transform: IntegerTransform<Int64> {
    return IntegerTransform(keyPath: \.int64Value)
}

/// Transformation that transforms node to `UInt8` value (unsigned char value).
public
var uint8Transform: IntegerTransform<UInt8> {
    return IntegerTransform(keyPath: \.uint8Value)
}

/// Transformation that transforms node to `UInt16` value (unsigned short value).
public
var uint16Transform: IntegerTransform<UInt16> {
    return IntegerTransform(keyPath: \.uint16Value)
}

/// Transformation that transforms node to `UInt32` value (unsigned int value).
public
var uint32Transform: IntegerTransform<UInt32> {
    return IntegerTransform(keyPath: \.uint32Value)
}

/// Transformation that transforms node to `UInt64` value (unsigned long long value).
public
var uint64Transform: IntegerTransform<UInt64> {
    return IntegerTransform(keyPath: \.uint64Value)
}
