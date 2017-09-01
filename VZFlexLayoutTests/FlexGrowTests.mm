//
//  FlexGrowTests.m
//  VZFlexLayout
//
//  Created by Sleen on 2017/8/11.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface FlexGrowTests : XCTestCase

@end

@implementation FlexGrowTests

- (void)testFlexGrow {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "flex-grow": 1,
                "_width": 100,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)testPaddingAndMargin {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "padding": 10,
        "children": [
            {
                "flex-grow": 1,
                "margin": 10,
                "_x": 20,
                "_y": 20,
                "_width": 60,
                "_height": 60
            }
        ]
    }
    )");
}

- (void)testTwoChild {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "flex-grow": 1,
                "_width": 80,
                "_height": 100
            },
            {
                "width": 20,
                "_x": 80,
                "_height": 100
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
                "width": 20,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "_x": 20,
                "_width": 80,
                "_height": 100
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
                "flex-grow": 1,
                "_width": 50,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "_x": 50,
                "_width": 50,
                "_height": 100
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
                "flex-grow": 1,
                "_width": 25,
                "_height": 100
            },
            {
                "flex-grow": 3,
                "_x": 25,
                "_width": 75,
                "_height": 100
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
                "flex-grow": 1,
                "width": 20,
                "_width": 35,
                "_height": 100
            },
            {
                "flex-grow": 3,
                "width": 20,
                "_x": 35,
                "_width": 65,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)testThreeChild {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 20,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "_x": 20,
                "_width": 60,
                "_height": 100
            },
            {
                "width": 20,
                "_x": 80,
                "_height": 100
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
                "flex-grow": 1,
                "_width": 40,
                "_height": 100
            },
            {
                "width": 20,
                "_x": 40,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "_x": 60,
                "_width": 40,
                "_height": 100
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
                "flex-grow": 1,
                "_width": 25,
                "_height": 100
            },
            {
                "flex-grow": 2,
                "_x": 25,
                "_width": 50,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "_x": 75,
                "_width": 25,
                "_height": 100
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
                "flex-grow": 1,
                "width": 10,
                "_width": 20,
                "_height": 100
            },
            {
                "flex-grow": 2,
                "width": 20,
                "_x": 20,
                "_width": 40,
                "_height": 100
            },
            {
                "flex-grow": 3,
                "width": 10,
                "_x": 60,
                "_width": 40,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)testLessThanOne {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "flex-grow": 0.1,
                "width": 10,
                "_width": 16,
                "_height": 100
            },
            {
                "flex-grow": 0.2,
                "width": 20,
                "_x": 16,
                "_width": 32,
                "_height": 100
            },
            {
                "flex-grow": 0.3,
                "width": 10,
                "_x": 48,
                "_width": 28,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)testVertical {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "direction": "vertical",
        "children": [
            {
                "flex-grow": 1,
                "height": 10,
                "_width": 100,
                "_height": 20
            },
            {
                "flex-grow": 2,
                "height": 20,
                "_y": 20,
                "_width": 100,
                "_height": 40
            },
            {
                "flex-grow": 3,
                "height": 10,
                "_y": 60,
                "_width": 100,
                "_height": 40
            }
        ]
    }
    )");
}

@end
