//
//  ValueNodeTests.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import XCTest
import Nimble

@testable
import OMM

class ValueNodeTests: XCTestCase {

    func test_SubscriptReturnsNodeWithSourceFromOriginalSourceArray() {
        let value = DummyScalar()
        let node = ValueNode(
            source: [value],
            path: ["test", 42]
        )

        expect(node[0] as? ValueNode).to(satisfy {
            expect($0.source) === value
            expect($0.path) == node.path + [0]
        })
    }

    func test_SubscriptReturnsNodeWithSourceFromOriginalSourceDictionary() {
        let value = DummyScalar()
        let node = ValueNode(
            source: ["key": value],
            path: ["test", 42]
        )

        expect(node["key"] as? ValueNode).to(satisfy {
            expect($0.source) === value
            expect($0.path) == node.path + ["key"]
        })
    }

    func test_SubscriptReturnsErrorNodeForAnyKeyIfSourceIsNotArrayOrDictionary() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )

        expect(node[42] as? ErrorNode).to(satisfy {
            let underlyingError = $0.error.underlyingError as? UnexpectedTypeError
            expect(underlyingError?.expectedType is [Any].Type).to(beTrue())
            expect(underlyingError?.actualType) === DummyScalar.self
            expect($0.error.path) == node.path
        })
        expect(node[""] as? ErrorNode).to(satisfy {
            let underlyingError = $0.error.underlyingError as? UnexpectedTypeError
            expect(underlyingError?.expectedType is [String: Any].Type).to(beTrue())
            expect(underlyingError?.actualType) === DummyScalar.self
            expect($0.error.path) == node.path
        })
    }

    func test_OptionalPropertyReturnsSameNode() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )

        expect(node.optional as? ValueNode).to(satisfy {
            expect($0.source) === node.source
            expect($0.path) == node.path
        })
    }

    func test_ValueMethodReturnsSourceOfNode() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )

        expect(try node.value(DummyScalar.self)) === node.source
    }

    func test_ValueMethodThrowsErrorIfSourceIsNotOfValueType() {
        let node = ValueNode(
            source: [] as [Int],
            path: ["test", 42]
        )

        expect(try node.value(DummyScalar.self)).to(throwError { (error: MappingError) in
            let underlyingError = error.underlyingError as? UnexpectedTypeError
            expect(underlyingError?.expectedType) === DummyScalar.self
            expect(underlyingError?.actualType is [Int].Type).to(beTrue())
            expect(error.path) == node.path
        })
    }

    func test_ValueTransformedWithMethodReturnsValueFromTransform() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )
        let transform = DummySuccessTransform(value: 42)

        expect(try node.value(transformedWith: transform)) == transform.value
    }

    func test_ValueTransformedWithMethodThrowsMappingErrorWithUnderlyingErrorFromTransform() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )
        let transform = DummyFailedTransform(error: DummyError())

        expect(try node.value(transformedWith: transform)).to(throwError { (error: MappingError) in
            expect(error.underlyingError) === transform.error
            expect(error.path) == node.path
        })
    }

    func test_ValueTransformedWithMethodThrowsMappingErrorFromTransform() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )
        let transform = DummyFailedTransform(error: MappingError(
            underlyingError: DummyError(),
            path: [42, 1]
        ))

        expect(try node.value(transformedWith: transform)).to(throwError { (error: MappingError) in
            expect(error.underlyingError) === transform.error.underlyingError
            expect(error.path) == transform.error.path
        })
    }

    func test_ArrayMethodReturnsArrayOfNodesWithSourcesFromOriginalArray() {
        let value = 42
        let node = ValueNode(
            source: [value],
            path: ["test", 42]
        )

        expect(try node.array().compactMap { $0 as? ValueNode }).to(satisfy {
            expect($0).to(haveCount(1))
            expect($0[0].source as? Int) == value
            expect($0[0].path) == node.path + [0]
        })

    }

    func test_ArrayMethodThrowsErrorIfSourceIsNotArray() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )

        expect(try node.array()).to(throwError { (error: MappingError) in
            let underlyingError = error.underlyingError as? UnexpectedTypeError
            expect(underlyingError?.expectedType is Array<Any>.Type).to(beTrue())
            expect(underlyingError?.actualType) === type(of: node.source)
            expect(error.path) == node.path
        })
    }

    func test_DictionaryMethodReturnsDictionaryOfNodesWithSourcesFromOriginalArray() {
        let value = 42
        let node = ValueNode(
            source: ["key": value],
            path: ["test", 42]
        )

        expect(try node.dictionary() as? [String: ValueNode]).to(satisfy {
            expect($0).to(haveCount(1))
            expect(Array($0.keys)).to(contain("key"))
            expect($0["key"]?.source as? Int) == value
            expect($0["key"]?.path) == node.path + ["key"]
        })
    }

    func test_DictionaryMethodThrowsErrorIfSourceIsNotDictionary() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )

        expect(try node.dictionary()).to(throwError { (error: MappingError) in
            let underlyingError = error.underlyingError as? UnexpectedTypeError
            expect(underlyingError?.expectedType is Dictionary<String, Any>.Type).to(beTrue())
            expect(underlyingError?.actualType) === type(of: node.source)
            expect(error.path) == node.path
        })
    }

}
