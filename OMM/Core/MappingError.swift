//
//  MappingError.swift
//  OMM
//
//  Created by Ivan Nikitin on 03/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

public
struct MappingError: ErrorType {

    public
    let underlyingError: ErrorType

    public
    let path: [SubscriptKey]

}

extension MappingError: CustomDebugStringConvertible {

    public
    var debugDescription: String {
        let path = self.path.map { String($0) }.joinWithSeparator(".")
        return "\(underlyingError) at \"\(path)\""
    }

}
