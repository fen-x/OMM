//
//  Satisfy.swift
//  OMM
//
//  Created by Ivan Nikitin on 06/10/16.
//  Copyright © 2016 Ivan Nikitin. All rights reserved.
//

import Nimble

func satisfy<T>(closure: @escaping (T) -> Void) -> Predicate<T> {
    return Predicate.simple("satisfy closure") { actualExpression in
        guard let actualValue = try actualExpression.evaluate() else {
            return .fail
        }
        let failures = gatherFailingExpectations { closure(actualValue) }
        return failures.isEmpty ? .matches : .fail
    }
}
