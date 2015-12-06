//
//  TransformError.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Represents transformation failure.
public
struct TransformError: ErrorType {

    /// Type of failed transformation.
    public
    let transformType: Any.Type

    /// Type of value that node tried to be transformed to.
    public
    let targetType: Any.Type

    /// Explanation of the error reason.
    public
    let reason: String

}

/// `CustomDebugStringConvertible` conformance.
extension TransformError: CustomDebugStringConvertible {

    /// A textual representation, suitable for debugging.
    public
    var debugDescription: String {
        return "Transform \"\(transformType)\" to type \"\(targetType)\" failed with reason \"\(reason)\""
    }
    
}
