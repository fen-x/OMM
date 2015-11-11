//
//  RawRepresentableOptionalTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 12/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
struct RawRepresentableOptionalTransform<T: RawRepresentable where T.RawValue: ScalarType>: TransformType {

    public
    init() { }

    public
    func applyToNode(node: NodeType) throws -> T? {
        return try T(rawValue: node.value(T.RawValue.self))
    }
    
}
