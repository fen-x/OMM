//
//  MappingError+Equatable.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import OMM

extension MappingError: Equatable { }

public
func ==(lhs: MappingError, rhs: MappingError) -> Bool {
    return lhs.underlyingError == rhs.underlyingError
        && lhs.path == rhs.path
}
