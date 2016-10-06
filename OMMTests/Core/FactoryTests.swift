//
//  FactoryTests.swift
//  OMM
//
//  Created by Ivan Nikitin on 08/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import XCTest
import Nimble

@testable
import OMM

class FactoryTests: XCTestCase {

    func test_ReturnsErrorNodeForNil() {
        let path = [1, 0, "test"] as [SubscriptKey]

        expect(node(for: nil, at: path) as? ErrorNode).to(satisfy {
            expect($0.error.underlyingError is UndefinedValueError).to(beTrue())
            expect($0.error.path) == path
            expect($0.recoverable).to(beTrue())
        })
    }

    func test_ReturnsErrorNodeForNull() {
        let path = [1, 0, "test"] as [SubscriptKey]

        expect(node(for: NSNull(), at: path) as? ErrorNode).to(satisfy {
            expect($0.error.underlyingError is NullValueError).to(beTrue())
            expect($0.error.path) == path
            expect($0.recoverable).to(beTrue())
        })
    }

    func test_ReturnsValueNodeWithGivenObject() {
        let source = DummyScalar()
        let path = [1, 0, "test"] as [SubscriptKey]

        expect(node(for: source, at: path) as? ValueNode).to(satisfy {
            expect($0.source) === source
            expect($0.path) == path
        })
    }

}
