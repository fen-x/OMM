//
//  Satisfy.swift
//  OMM
//
//  Created by Ivan Nikitin on 06/10/16.
//  Copyright © 2016 Ivan Nikitin. All rights reserved.
//

import Nimble

func satisfy<T>(closure: @escaping (T) -> Void) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "satisfy closure"
        guard let actualValue = try actualExpression.evaluate() else {
            return false
        }
        return gatherFailingExpectations { closure(actualValue) }.isEmpty
    }
}
