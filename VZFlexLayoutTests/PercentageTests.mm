//
//  PercentageTests.m
//  VZFlexLayout
//
//  Created by Sleen on 2017/8/28.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface PercentageTests : XCTestCase

@end

@implementation PercentageTests

- (void)testWidthHeight {
    XCTAssertLayout(@R"(
    {
        "height": 50,
        "width": 50,
        "children": [
            {
                "width": "40%",
                "height": "80%",
                "_width": 20,
                "_height": 40
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(50, 50, 1, @R"(
    {
        "width": "40%",
        "height": "80%",
        "_width": 20,
        "_height": 40
    }
    )");
}

- (void)testFlexBasis {
    XCTAssertLayout(@R"(
    {
        "height": 50,
        "width": 50,
        "children": [
            {
                "flex-basis": "40%",
                "_width": 20,
                "_height": 50
            }
        ]
    }
    )");
}

- (void)testMinWidthHeight {
    XCTAssertLayout(@R"(
    {
        "height": 50,
        "width": 50,
        "children": [
            {
                "height": 20,
                "min-width": "40%",
                "min-height": "80%",
                "_width": 20,
                "_height": 40
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(50, 50, 1, @R"(
    {
        "width": 0,
        "height": 0,
        "min-width": "40%",
        "min-height": "80%",
        "_width": 20,
        "_height": 40
    }
    )");
}

- (void)testMaxWidthHeight {
    XCTAssertLayout(@R"(
    {
        "height": 50,
        "width": 50,
        "children": [
            {
                "flex-grow": 1,
                "max-width": "40%",
                "max-height": "80%",
                "_width": 20,
                "_height": 40
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(50, 50, 1, @R"(
    {
        "max-width": "40%",
        "max-height": "80%",
        "_width": 20,
        "_height": 40
    }
    )");
}

- (void)testMargin {
    XCTAssertLayout(@R"(
    {
        "height": 50,
        "width": 50,
        "children": [
            {
                "margin": "10%",
                "flex-grow": 1,
                "_x": 5,
                "_y": 5,
                "_width": 40,
                "_height": 40
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(50, 50, 1, @R"(
    {
        "margin": "10%",
        "_x": 5,
        "_y": 5,
        "_width": 40,
        "_height": 40
    }
    )");
}

- (void)testPadding {
    XCTAssertLayout(@R"(
    {
        "height": 50,
        "width": 50,
        "children": [
            {
                "padding": "10%",
                "align-self": "start",
                "_width": 10,
                "_height": 10
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(50, 50, 1, @R"(
    {
        "padding": "10%",
        "_width": 50,
        "_height": 50,
        "children": [
            {
                "flex-grow": 1,
                "_x": 5,
                "_y": 5,
                "_width": 40,
                "_height": 40
            }
        ]
    }
    )");
}

- (void)testSpacingLineSpacing {
    XCTAssertLayout(@R"(
    {
        "height": 50,
        "width": 50,
        "spacing": "10%"
        "line-spacing": "10%"
        "children": [
            {
                "width": 20,
                "height": 20
            },
            {
                "width": 20,
                "height": 20,
                "_x": 25
            },
            {
                "width": 20,
                "height": 20,
                "_y": 25
            },
            {
                "width": 20,
                "height": 20,
                "_x": 25,
                "_y": 25
            }
        ]
    }
    )");
}

- (void)testNested {
    XCTAssertLayoutWithConfig(50, 50, 1, @R"(
    {
        "direction": "vertical",
        "height": "80%",
        "_width": 50,
        "_height": 40,
        "children": [
            {
                "height": "50%",
                "_width": 50,
                "_height": 20,
                "children": [
                    {
                        "width": "50%",
                        "margin-bottom": "10%",
                        "margin-right": "10%",
                        "_width": 25,
                        "_height": 15
                    },
                    {
                        "margin-top": "10%",
                        "_x": 30,
                        "_y": 5,
                        "_height": 15
                    }
                ]
            },
            {
                "margin": "10%",
                "_x": 5,
                "_y": 25,
                "_width": 40
            }
        ]
    }
    )");
}

- (void)testUndefined {
    XCTAssertLayout(@R"(
    {
        "width": "40%",
        "height": "80%",
        "_width": 0,
        "_height": 0
    }
    )");
    
    XCTAssertLayout(@R"(
    {
        "_width": 10,
        "_height": 10,
        "children": [
            {
                "width": 10,
                "height": 10
            },
            {
                "width": "40%",
                "height": "80%",
                "_x": 10,
                "_width": 0,
                "_height": 0
            }
        ]
    }
    )");
}

@end
