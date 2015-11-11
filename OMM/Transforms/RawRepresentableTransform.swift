//
//  RawRepresentableTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
struct RawRepresentableTransform<T: RawRepresentable where T.RawValue: ScalarType>: TransformType {

    private
    let transform = RawRepresentableOptionalTransform<T>()

    public
    init() { }

    public
    func applyToNode(node: NodeType) throws -> T {
        guard let value = try transform.applyToNode(node) else {
            throw errorWithReason("Unexpected raw value")
        }
        return value
    }

}
