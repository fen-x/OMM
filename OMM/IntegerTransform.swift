//
//  IntegerTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSNumber

public
struct IntegerTransform<T: IntegerType>: TransformType {

    private
    let transform: NSNumber -> T

    private
    init(transform: NSNumber -> T) {
        self.transform = transform
    }

    public
    func applyToNode(node: NodeType) throws -> T {
        return try transform(node.value(NSNumber))
    }

}

public
var Int8Transform: IntegerTransform<Int8> {
    return IntegerTransform { $0.charValue }
}

public
var Int16Transform: IntegerTransform<Int16> {
    return IntegerTransform { $0.shortValue }
}

public
var Int32Transform: IntegerTransform<Int32> {
    return IntegerTransform { $0.intValue }
}

public
var Int64Transform: IntegerTransform<Int64> {
    return IntegerTransform { $0.longLongValue }
}

public
var UInt8Transform: IntegerTransform<UInt8> {
    return IntegerTransform { $0.unsignedCharValue }
}

public
var UInt16Transform: IntegerTransform<UInt16> {
    return IntegerTransform { $0.unsignedShortValue }
}

public
var UInt32Transform: IntegerTransform<UInt32> {
    return IntegerTransform { $0.unsignedIntValue }
}

public
var UInt64Transform: IntegerTransform<UInt64> {
    return IntegerTransform { $0.unsignedLongLongValue }
}
