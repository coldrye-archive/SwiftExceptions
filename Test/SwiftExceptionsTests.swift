//
//  SwiftExceptionsTests.swift
//  SwiftExceptions
//
//  Created by Carsten Klein on 15-03-12.
//  Copyright (c) 2015 vibeswift. All rights reserved.
//

import XCTest
import SwiftExceptions
import SXCTAssertions

class SwiftExceptionsTests: XCTestCase {

    func testTryCatch() {
        SXCTAssertNoThrow({
            try({
                NSException(name: NSInvalidArgumentException, reason: nil, userInfo: nil).raise()
                },
                catch: { exception in
                    XCTAssertEqual(exception.name, NSInvalidArgumentException)
            })
            }())
    }

    func testTryCatchThrows() {
        SXCTAssertThrowsSpecificNamed({
            try({
                NSException(name: NSInvalidArgumentException, reason: nil, userInfo: nil).raise()
                },
                catch: { exception in
                    NSException(name: NSInvalidArchiveOperationException, reason: nil, userInfo: nil).raise()
            })
            }(), NSException.self, NSInvalidArchiveOperationException)
    }

    func testTryFinally() {
        SXCTAssertThrowsSpecificNamed({
            var finallyCalled : Bool = false
            try({
                NSException(name: NSInvalidArgumentException, reason: nil, userInfo: nil).raise()
                },
                finally: {
                    finallyCalled = true
            })
            XCTAssertTrue(finallyCalled)
            }(), NSException.self, NSInvalidArgumentException)
    }

    func testTryFinallyThrows() {
        // Requires bugfixes to compiler
        //var finallyCalled : Bool = false
        SXCTAssertThrowsSpecificNamed({
            try({
                NSException(name: NSInvalidArgumentException, reason: nil, userInfo: nil).raise()
                },
                finally: {
                    //finallyCalled = true
                    NSException(name: NSInvalidArchiveOperationException, reason: nil, userInfo: nil).raise()
            })
            }(), NSException.self, NSInvalidArchiveOperationException)
        //XCTAssertTrue(finallyCalled)
    }

    func testTryCatchFinally() {
        SXCTAssertNoThrow({
            var finallyCalled : Bool = false
            try({
                NSException(name: NSInvalidArgumentException, reason: nil, userInfo: nil).raise()
                },
                catch: { exception in
                    XCTAssertEqual(exception.name, NSInvalidArgumentException)
                },
                finally: {
                    finallyCalled = true
            })
            XCTAssertTrue(finallyCalled)
            // omitting message parameter results in unrelated compilation error
            }(), message: "exception should have been caught")
    }

    func testTryCatchThrowsFinally() {
        SXCTAssertThrowsSpecificNamed({
            var finallyCalled : Bool = false
            try({
                NSException(name: NSInvalidArgumentException, reason: nil, userInfo: nil).raise()
                },
                catch: { exception in
                    NSException(name: NSInvalidArchiveOperationException, reason: nil, userInfo: nil).raise()
                },
                finally: {
                    finallyCalled = true
            })
            XCTAssertTrue(finallyCalled)
            }(), NSException.self, NSInvalidArchiveOperationException)
    }

    func testTryCatchTryFinally() {
        SXCTAssertNoThrow({
            try({
                var finallyCalled : Bool = false
                try({
                    NSException(name: NSInvalidArgumentException, reason: nil, userInfo: nil).raise()
                    },
                    finally: {
                        finallyCalled = true
                })
                XCTAssertTrue(finallyCalled)
                },
                catch: { exception in
                    XCTAssertEqual(exception.name, NSInvalidArgumentException)
            })
            }())
    }

    func testTryFinallyTryFinally() {
        SXCTAssertThrowsSpecificNamed({
            var finallyCalled : Bool = false
            try({
                var innerFinallyCalled : Bool = false
                try({
                    NSException(name: NSInvalidArgumentException, reason: nil, userInfo: nil).raise()
                    },
                    finally: {
                        innerFinallyCalled = true
                })
                XCTAssertTrue(innerFinallyCalled)
                },
                finally: {
                    finallyCalled = true
            })
            XCTAssertTrue(finallyCalled)
            }(), NSException.self, NSInvalidArgumentException)
    }
}
