//
//  SequenceType+Utils.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

extension Sequence {

    func toDictionary<Key, Value>(transform: (Self.Iterator.Element) throws -> (Key, Value)) rethrows -> [Key: Value] {
        var result = [Key: Value]()
        for (key, value) in try map(transform) {
            result[key] = value
        }
        return result
    }

}
