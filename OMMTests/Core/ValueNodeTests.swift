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
        let node = ValueNode(
            source: [DummyScalar()],
            path: ["test", 42]
        )

        expect(node[0] as? ValueNode) == ValueNode(
            source: node.source[0],
            path: node.path + [0]
        )
    }

    func test_SubscriptReturnsNodeWithSourceFromOriginalSourceDictionary() {
        let node = ValueNode(
            source: ["key": DummyScalar()],
            path: ["test", 42]
        )

        expect(node["key"] as? ValueNode) == ValueNode(
            source: node.source["key"]!,
            path: node.path + ["key"]
        )
    }

    func test_SubscriptReturnsErrorNodeForAnyKeyIfSourceIsNotArrayOrDictionary() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )

        expect(node[42] as? ErrorNode) == ErrorNode(
            error: UnexpectedTypeError(expectedType: [AnyObject].self, actualType: DummyScalar.self),
            path: node.path,
            recoverable: false
        )
        expect(node[""] as? ErrorNode) == ErrorNode(
            error: UnexpectedTypeError(expectedType: [String: AnyObject].self, actualType: DummyScalar.self),
            path: node.path,
            recoverable: false
        )
    }

    func test_OptionalPropertyReturnsSameNode() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )

        expect(node.optional as? ValueNode) == node
    }

    func test_ValueMethodReturnsSourceOfNode() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )

        expect(try node.value() as DummyScalar) === node.source
    }

    func test_ValueMethodThrowsErrorIfSourceIsNotOfValueType() {
        let node = ValueNode(
            source: [],
            path: ["test", 42]
        )

        expect(try node.value() as DummyScalar).to(throwError { (error: MappingError) in
            expect(error) == MappingError(
                underlyingError: UnexpectedTypeError(
                    expectedType: DummyScalar.self,
                    actualType: node.source.dynamicType
                ),
                path: node.path
            )
        })
    }

    func test_ArrayMethodReturnsArrayOfNodesWithSourcesFromOriginalArray() {
        let node = ValueNode(
            source: [42],
            path: ["test", 42]
        )

        expect(try node.array().flatMap { $0 as? ValueNode }) == [
            ValueNode(
                source: node.source[0],
                path: node.path + [0]
            )
        ]
    }

    func test_ArrayMethodThrowsErrorIfSourceIsNotArray() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )

        expect(try node.array()).to(throwError { (error: MappingError) in
            expect(error) == MappingError(
                underlyingError: UnexpectedTypeError(
                    expectedType: [AnyObject].self,
                    actualType: node.source.dynamicType
                ),
                path: node.path
            )
        })
    }

    func test_DictionaryMethodReturnsDictionaryOfNodesWithSourcesFromOriginalArray() {
        let node = ValueNode(
            source: ["key": 42],
            path: ["test", 42]
        )

        expect(try node.dictionary() as? [String: ValueNode]) == [
            "key": ValueNode(
                source: node.source["key"],
                path: node.path + ["key"]
            )
        ]
    }

    func test_DictionaryMethodThrowsErrorIfSourceIsNotDictionary() {
        let node = ValueNode(
            source: DummyScalar(),
            path: ["test", 42]
        )

        expect(try node.dictionary()).to(throwError { (error: MappingError) in
            expect(error) == MappingError(
                underlyingError: UnexpectedTypeError(
                    expectedType: [String: AnyObject].self,
                    actualType: node.source.dynamicType
                ),
                path: node.path
            )
        })
    }

}
