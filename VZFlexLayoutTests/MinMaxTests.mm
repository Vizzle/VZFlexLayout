//
//  MinMaxTests.m
//  VZFlexLayout
//
//  Created by Sleen on 2017/8/28.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MinMaxTests : XCTestCase

@end

@implementation MinMaxTests

- (void)testMinWidth {
    XCTAssertLayout(@R"(
    {
        "min-width": 50,
        "_width": 50
    }
    )");

    XCTAssertLayout(@R"(
    {
        "min-width": 50,
        "_width": 50,
        "children": [
            {
                "width": 10
            }
        ]
    }
    )");

    XCTAssertLayout(@R"(
    {
        "min-width": 50,
        "_width": 100,
        "children": [
            {
                "width": 100
            }
        ]
    }
    )");

    XCTAssertLayout(@R"(
    {

        "_width": 10,
        "children": [
            {
                "min-width": 10,
                "_width": 10
            }
        ]
    }
    )");
}

- (void)testMinHeight {
    XCTAssertLayout(@R"(
    {
        "min-height": 50,
        "_height": 50
    }
    )");

    XCTAssertLayout(@R"(
    {
        "min-height": 50,
        "_height": 50,
        "children": [
            {
                "height": 10
            }
        ]
    }
    )");

    XCTAssertLayout(@R"(
    {
        "min-height": 50,
        "_height": 100,
        "children": [
            {
                "height": 100
            }
        ]
    }
    )");
}

- (void)testMaxWidth {
    XCTAssertLayout(@R"(
    {
        "max-width": 50,
        "_width": 0
    }
    )");

    XCTAssertLayout(@R"(
    {
        "max-width": 50,
        "_width": 10,
        "children": [
            {
                "width": 10
            }
        ]
    }
    )");

    XCTAssertLayout(@R"(
    {
        "max-width": 50,
        "_width": 50,
        "children": [
            {
                "width": 100
            }
        ]
    }
    )");
}

- (void)testMaxHeight {
    XCTAssertLayout(@R"(
    {
        "max-height": 50,
        "_height": 0
    }
    )");

    XCTAssertLayout(@R"(
    {
        "max-height": 50,
        "_height": 10,
        "children": [
            {
                "height": 10
            }
        ]
    }
    )");

    XCTAssertLayout(@R"(
    {
        "max-height": 50,
        "_height": 50,
        "children": [
            {
                "height": 100
            }
        ]
    }
    )");
    
    XCTAssertLayout(@R"(
    {
        "height": 50,
        "children": [
            {
                "max-height": 20,
                "_height": 20
            }
        ]
    }
    )");
}

@end
