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
        let node = ErrorNode(
            error: DummyError(),
            path: [0, "test", 1],
            recoverable: true
        )

        expect(node[42] as? ErrorNode) == node
        expect(node[""] as? ErrorNode) == node
    }

    func test_OptionalPropertyReturnsNilIfNodeIsRecoverable() {
        let node = ErrorNode(
            error: DummyError(),
            path: [0, "test", 1],
            recoverable: true
        )

        expect(node.optional as? ErrorNode).to(beNil())
    }

    func test_OptionalPropertyReturnsSameNodeIfItIsNotRecoverable() {
        let node = ErrorNode(
            error: DummyError(),
            path: [0, "test", 1],
            recoverable: false
        )

        expect(node.optional as? ErrorNode) == node
    }

    func test_ValueMethodThrowsGivenMappingError() {
        let node = ErrorNode(
            error: DummyError(),
            path: [0, "test", 1],
            recoverable: true
        )

        expect(try node.value() as DummyScalar).to(throwError { (error: MappingError) in
            expect(error) == node.error
        })
    }

    func test_ArrayMethodThrowsGivenMappingError() {
        let node = ErrorNode(
            error: DummyError(),
            path: [0, "test", 1],
            recoverable: true
        )

        expect(try node.array()).to(throwError { (error: MappingError) in
            expect(error) == node.error
        })
    }

    func test_DictionaryMethodThrowsGivenMappingError() {
        let node = ErrorNode(
            error: DummyError(),
            path: [0, "test", 1],
            recoverable: true
        )

        expect(try node.dictionary()).to(throwError { (error: MappingError) in
            expect(error) == node.error
        })
    }

}
