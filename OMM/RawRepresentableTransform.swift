//
//  RawRepresentableTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
struct RawRepresentableTransform<T: RawRepresentable where T.RawValue: ScalarType>: TransformType {

    let defaultValue: T?

    public
    init(defaultValue: T? = nil) {
        self.defaultValue = defaultValue
    }

    public
    func applyToNode(node: NodeType) throws -> T {
        guard let value = try T(rawValue: node.value(T.RawValue.self)) ?? defaultValue else {
            throw errorWithReason("Unexpected raw value")
        }
        return value
    }

}
