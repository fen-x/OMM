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

        expect(node[42] as? ErrorNode).to(satisfy {
            expect($0.error.underlyingError) === node.error.underlyingError
            expect($0.error.path) == node.error.path
            expect($0.recoverable) == node.recoverable
        })
        expect(node[""] as? ErrorNode).to(satisfy {
            expect($0.error.underlyingError) === node.error.underlyingError
            expect($0.error.path) == node.error.path
            expect($0.recoverable) == node.recoverable
        })
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

        expect(node.optional as? ErrorNode).to(satisfy {
            expect($0.error.underlyingError) === node.error.underlyingError
            expect($0.error.path) == node.error.path
            expect($0.recoverable) == node.recoverable
        })
    }

    func test_ValueMethodThrowsGivenMappingError() {
        let node = ErrorNode(
            error: DummyError(),
            path: [0, "test", 1],
            recoverable: true
        )

        expect(try node.value(DummyScalar.self)).to(throwError { (error: MappingError) in
            expect(error.underlyingError) === node.error.underlyingError
            expect(error.path) == node.error.path
        })
    }

    func test_ValueTransformedWithMethodThrowsGivenMappingError() {
        let node = ErrorNode(
            error: DummyError(),
            path: [0, "test", 1],
            recoverable: true
        )

        expect(try node.value(transformedWith: DummyTransform())).to(throwError { (error: MappingError) in
            expect(error.underlyingError) === node.error.underlyingError
            expect(error.path) == node.error.path
        })
    }

    func test_ArrayMethodThrowsGivenMappingError() {
        let node = ErrorNode(
            error: DummyError(),
            path: [0, "test", 1],
            recoverable: true
        )

        expect(try node.array()).to(throwError { (error: MappingError) in
            expect(error.underlyingError) === node.error.underlyingError
            expect(error.path) == node.error.path
        })
    }

    func test_DictionaryMethodThrowsGivenMappingError() {
        let node = ErrorNode(
            error: DummyError(),
            path: [0, "test", 1],
            recoverable: true
        )

        expect(try node.dictionary()).to(throwError { (error: MappingError) in
            expect(error.underlyingError) === node.error.underlyingError
            expect(error.path) == node.error.path
        })
    }

}
