//
//  FlexBasisTests.m
//  VZFlexLayout
//
//  Created by Sleen on 2017/8/14.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface FlexBasisTests : XCTestCase

@end

@implementation FlexBasisTests

- (void)testFlexBasis {
    XCTAssertLayout(@R"(
{
    "height": 100,
    "_width": 100,
    "children": [
        {
            "flex-basis": 50,
            "_width": 50,
            "_height": 100
        },
        {
            "flex-basis": 50,
            "_x": 50,
            "_width": 50,
            "_height": 100
        }
    ]
}
    )");
}

- (void)testFlexBasisGrow {
    XCTAssertLayout(@R"(
{
    "height": 100,
    "width": 100,
    "children": [
        {
            "flex-basis": 20,
            "measure-width": 20,
            "flex-grow": 1,
            "_width": 45,
            "_height": 100
        },
        {
            "flex-basis": 30,
            "measure-width": 20,
            "flex-grow": 1,
            "_x": 45,
            "_width": 55,
            "_height": 100
        }
    ]
}
    )");

    XCTAssertLayout(@R"(
{
    "height": 100,
    "width": 100,
    "children": [
        {
            "flex-basis": 0,
            "measure-width": 20,
            "flex-grow": 1,
            "_width": 50,
            "_height": 100
        },
        {
            "flex-basis": 0,
            "measure-width": 50,
            "flex-grow": 1,
            "_x": 50,
            "_width": 50,
            "_height": 100
        }
    ]
}
    )");
}

- (void)testFlexBasisShrink {
    XCTAssertLayout(@R"(
{
    "height": 100,
    "width": 100,
    "children": [
        {
            "flex-basis": 100,
            "measure-width": 20,
            "_width": 40,
            "_height": 100
        },
        {
            "flex-basis": 150,
            "measure-width": 20,
            "_x": 40,
            "_width": 60,
            "_height": 100
        }
    ]
}
    )");
}

- (void)testPriority {
    XCTAssertLayout(@R"(
{
    "children": [
        {
            "width": 50,
            "flex-basis": 20,
            "_width": 20,
        }
    ],
    "_width": 20
}
    )");

    XCTAssertLayout(@R"(
{
    "direction": "vertical",
    "children": [
        {
            "height": 50,
            "flex-basis": 20,
            "_height": 20,
        }
    ],
    "_height": 20
}
    )");
}

@end
