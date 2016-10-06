//
//  MappingError.swift
//  OMM
//
//  Created by Ivan Nikitin on 03/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Represents error occured during mapping proccess.
public
struct MappingError: Error {

    /// An error that was encountered in an underlying implementation and caused the error that the receiver represents to occur.
    public
    let underlyingError: Error

    /// Path from the root node to node that has thrown error.
    public
    let path: [SubscriptKey]

}

/// `CustomDebugStringConvertible` conformance.
extension MappingError: CustomDebugStringConvertible {

    /// A textual representation, suitable for debugging.
    public
    var debugDescription: String {
        let path = self.path.map { String(describing: $0) }.joined(separator: ".")
        return "\(underlyingError) at \"\(path)\""
    }

}
