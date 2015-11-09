//
//  TransformError.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
struct TransformError: ErrorType {

    public
    let transformType: Any.Type

    public
    let targetType: Any.Type

    public
    let reason: String

}

extension TransformError: CustomDebugStringConvertible {

    public
    var debugDescription: String {
        return "Transform \"\(transformType)\" to type \"\(targetType)\" failed with reason \"\(reason)\""
    }
    
}
