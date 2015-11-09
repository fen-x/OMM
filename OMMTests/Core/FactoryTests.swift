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
        let node = NodeForObject(nil, path: path)

        expect(node as? ErrorNode) == ErrorNode(
            error: UndefinedValueError(),
            path: path,
            recoverable: true
        )
    }

    func test_ReturnsErrorNodeForNull() {
        let path = [1, 0, "test"] as [SubscriptKey]
        let node = NodeForObject(NSNull(), path: path)

        expect(node as? ErrorNode) == ErrorNode(
            error: NullValueError(),
            path: path,
            recoverable: true
        )
    }

    func test_ReturnsValueNodeWithGivenObject() {
        let source = DummyScalar()
        let path = [1, 0, "test"] as [SubscriptKey]
        let node = NodeForObject(source, path: path)

        expect(node as? ValueNode) == ValueNode(
            source: source,
            path: path
        )
    }

}
