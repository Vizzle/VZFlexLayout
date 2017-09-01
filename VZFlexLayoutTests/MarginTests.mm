//
//  MarginTests.m
//  VZFlexLayout
//
//  Created by Sleen on 2017/8/8.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTestCase+Helper.h"

@interface MarginTests : XCTestCase

@end

@implementation MarginTests

- (void)testMargin {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin": 10,
                "_x": 10,
                "_y": 10
            }
        ]
    }
    )");
    
    XCTAssertLayout(@R"(
    {
        "direction": "vertical",
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin": 10,
                "_x": 10,
                "_y": 10
            }
        ]
    }
    )");
}

- (void)testNegativeMargin {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin": -10,
                "_x": -10,
                "_y": -10
            }
        ]
    }
    )");
    
    XCTAssertLayout(@R"(
    {
        "direction": "vertical",
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin": -10,
                "_x": -10,
                "_y": -10
            }
        ]
    }
    )");
    
    XCTAssertLayout(@R"(
    {
        "direction": "vertical",
        "width": 100,
        "height": 100,
        "children": [
            {
                "height": 50,
                "margin": -10,
                "_x": -10,
                "_y": -10,
                "_width": 120
            }
        ]
    }
    )");
}

- (void)testMarginAuto {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin": 10,
                "margin-left": "auto",
                "margin-top": "auto",
                "_x": 40,
                "_y": 40
            }
        ]
    }
    )");
    
    XCTAssertLayout(@R"(
    {
        "direction": "vertical",
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin": 10,
                "margin-left": "auto",
                "margin-top": "auto",
                "_x": 40,
                "_y": 40
            }
        ]
    }
    )");
}

- (void)testMarginAutoWithSiblingNode {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 20,
                "height": 20,
                "margin": "auto",
                "_x": 30,
                "_y": 40
            },
            {
                "width": 20,
                "height": 20,
                "_x": 80,
                "_y": 0
            }
        ]
    }
    )");
}

- (void)testMarginWithFlexGrow {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin": 10,
                "flex-grow": 1,
                "_x": 10,
                "_y": 10,
                "_width": 80
            }
        ]
    }
    )");
}

- (void)testMarginAutoWithFlexGrow {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin": 10,
                "margin-left": "auto",
                "margin-top": "auto",
                "flex-grow": 1,
                "_x": 0,
                "_y": 40,
                "_width": 90
            }
        ]
    }
    )");
}

- (void)testMarginChildBiggerThanParent {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 120,
                "height": 120,
                "margin": "auto",
                "_width": 100,
            }
        ]
    }
    )");
    
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 120,
                "height": 120,
                "margin": 10,
                "_x": 10,
                "_y": 10,
                "_width": 80,
                "_height": 120
            }
        ]
    }
    )");
    
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 120,
                "height": 120,
                "margin-left": "auto",
                "margin-right": 10,
                "_width": 90,
                "_height": 120
            }
        ]
    }
    )");
}

@end
