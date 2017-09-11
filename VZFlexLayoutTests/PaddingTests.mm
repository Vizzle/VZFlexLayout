//
//  PaddingTests.m
//  VZFlexLayout
//
//  Created by Sleen on 2017/8/10.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface PaddingTests : XCTestCase

@end

@implementation PaddingTests

- (void)testPadding {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "padding": 10,
        "children": [
            {
                "_x": 10,
                "_y": 10,
                "_height": 80
            }
        ]
    }
    )");
}

- (void)testZeroSize {
    XCTAssertLayout(@R"(
    {
        "padding": 10,
        "_width": 20,
        "_height": 20
    }
    )");
}

- (void)testMatchChild {
    XCTAssertLayout(@R"(
    {
        "padding": 10,
        "_width": 70,
        "_height": 70,
        "children": [
            {
                "width": 50,
                "height": 50,
                "_x": 10,
                "_y": 10
            }
        ]
    }
    )");
}

- (void)testChildFlexGrow {
    XCTAssertLayout(@R"(
    {
        "padding": 10,
        "width": 100,
        "height": 100,
        "children": [
            {
                "flex-grow": 1,
                "_x": 10,
                "_y": 10,
                "_width": 80,
                "_height": 80
            }
        ]
    }
    )");
}

- (void)testCenterChild {
    XCTAssertLayout(@R"(
    {
        "padding-top": 10,
        "padding-right": 20,
        "padding-bottom": 30,
        "padding-left": 40,
        "width": 100,
        "height": 100,
        "align-items": "center",
        "justify-content": "center",
        "children": [
            {
                "width": 10,
                "height": 10,
                "_x": 55,
                "_y": 35
            }
        ]
    }
    )");
}

- (void)testAspectRatio {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "_height": 50,
        "children": [
            {
                "flex-grow": 1,
                "_width": 50,
                "_height": 50,
                "children": [
                    {
                        "padding-top": "100%",
                        "_height": 50
                    }
                ]
            },
            {
                "flex-grow": 1,
                "_width": 50,
                "_height": 50,
                "_x": 50,
                "children": [
                    {
                        "padding-top": "100%",
                        "_height": 50
                    }
                ]
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(100, FlexAuto, 1, @R"(
    {
        "_width": 100,
        "_height": 50,
        "children": [
            {
                "flex-grow": 1,
                "_width": 50,
                "_height": 50,
                "children": [
                    {
                        "padding-top": "100%",
                        "_height": 50
                    }
                ]
            },
            {
                "flex-grow": 1,
                "_width": 50,
                "_height": 50,
                "_x": 50,
                "children": [
                    {
                        "padding-top": "100%",
                        "_height": 50
                    }
                ]
            }
        ]
    }
    )");
}

@end
