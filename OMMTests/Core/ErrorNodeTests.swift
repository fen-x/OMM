//
//  ErrorNodeTests.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import XCTest
import Nimble

@testable
import OMM

class ErrorNodeTests: XCTestCase {

    func test_SubscriptReturnsSameErrorNodeForAnyKey() {
        let node = errorNode()

        expect(node[42] as? ErrorNode) == node
        expect(node[""] as? ErrorNode) == node
    }

    func test_OptionalPropertyReturnsNilIfNodeIsRecoverable() {
        let node = errorNode(recoverable: true)

        expect(node.optional as? ErrorNode).to(beNil())
    }

    func test_OptionalPropertyReturnsSameNodeIfItIsNotRecoverable() {
        let node = errorNode(recoverable: false)

        expect(node.optional as? ErrorNode) == node
    }

    func test_ValueMethodThrowsGivenMappingError() {
        let node = errorNode()

        expect(try node.value() as DummyScalar).to(throwError(node.error))
    }

    func test_ArrayMethodThrowsGivenMappingError() {
        let node = errorNode()

        expect(try node.array()).to(throwError(node.error))
    }

    func test_DictionaryMethodThrowsGivenMappingError() {
        let node = errorNode()

        expect(try node.dictionary()).to(throwError(node.error))
    }

}

private
func errorNode(recoverable recoverable: Bool = true) -> ErrorNode {
    return ErrorNode(
        error: MappingError(
            underlyingError: DummyError(),
            path: [0, "test", 1]
        ),
        recoverable: recoverable
    )
}
