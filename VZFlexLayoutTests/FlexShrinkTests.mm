//
//  FlexShrinkTests.m
//  VZFlexLayout
//
//  Created by Sleen on 2017/8/14.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface FlexShrinkTests : XCTestCase

@end

@implementation FlexShrinkTests

- (void)testFlexShrink {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 200,
                "height": 200,
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
                "width": 200,
                "height": 200,
                "flex-shrink": 0,
                "_width": 200
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
                "margin": 10,
                "width": 100,
                "_x": 20,
                "_y": 20,
                "_width": 60,
                "_height": 60
            }
        ]
    }
    )");

    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "padding": 10,
        "children": [
            {
                "margin": 10,
                "width": 100,
                "flex-shrink": 0,
                "_x": 20,
                "_y": 20,
                "_width": 100,
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
                "width": 100,
                "_width": 50,
                "_height": 100
            },
            {
                "width": 100,
                "_x": 50,
                "_width": 50
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
                "width": 100,
                "_width": 40,
                "_height": 100
            },
            {
                "width": 150,
                "_x": 40,
                "_width": 60,
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
                "flex-shrink": 0,
                "width": 50,
                "_height": 100
            },
            {
                "width": 100,
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
                "flex-shrink": 0,
                "width": 100,
                "_height": 100
            },
            {
                "width": 100,
                "_x": 100,
                "_width": 0,
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
                "flex-shrink": 1,
                "width": 100,
                "_width": 75,
                "_height": 100
            },
            {
                "flex-shrink": 3,
                "width": 100,
                "_x": 75,
                "_width": 25,
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
                "width": 50,
                "_width": 25,
                "_height": 100
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 25,
                "_height": 100
            },
            {
                "width": 50,
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
                "flex-shrink": 0,
                "width": 40,
                "_height": 100
            },
            {
                "width": 100,
                "_x": 40,
                "_width": 20,
                "_height": 100
            },
            {
                "flex-shrink": 0,
                "width": 40,
                "_x": 60,
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
                "flex-shrink": 1,
                "width": 40,
                "_width": 35,
                "_height": 100
            },
            {
                "flex-shrink": 2,
                "width": 40,
                "_x": 35,
                "_width": 30,
                "_height": 100
            },
            {
                "flex-shrink": 1,
                "width": 40,
                "_x": 65,
                "_width": 35,
                "_height": 100
            }
        ]
    }
    )");

    XCTAssertLayout(@R"(
    {
        "width": 90,
        "height": 100,
        "children": [
            {
                "width": 30,
                "_width": 15,
                "_height": 100
            },
            {
                "width": 60,
                "_x": 15,
                "_width": 30,
                "_height": 100
            },
            {
                "width": 90,
                "_x": 45,
                "_width": 45,
                "_height": 100
            }
        ]
    }
    )");

    XCTAssertLayout(@R"(
    {
        "width": 90,
        "height": 100,
        "children": [
            {
                "flex-shrink": 3,
                "width": 30,
                "_width": 3,
                "_height": 100
            },
            {
                "flex-shrink": 2,
                "width": 60,
                "_x": 3,
                "_width": 24,
                "_height": 100
            },
            {
                "flex-shrink": 1,
                "width": 90,
                "_x": 27,
                "_width": 63,
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
        "height": 90,
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 3,
                "height": 30,
                "_width": 100,
                "_height": 3
            },
            {
                "flex-shrink": 2,
                "height": 60,
                "_y": 3,
                "_width": 100,
                "_height": 24
            },
            {
                "flex-shrink": 1,
                "height": 90,
                "_y": 27,
                "_width": 100,
                "_height": 63
            }
        ]
    }
    )");
}

- (void)testFlexShrinkZero {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "flex-shrink": 0,
                "width": 50,
                "_height": 100
            },
            {
                "width": 100,
                "_x": 50,
                "_width": 0,
                "_height": 100
            },
            {
                "flex-shrink": 0,
                "width": 150,
                "_x": 50,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)testSimulatePriority {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 50,
                "_height": 100
            },
            {
                "width": 100,
                "flex-shrink": 1000000,
                "_x": 50,
                "_width": 0,
                "_height": 100
            },
            {
                "width": 150,
                "flex-shrink": 1000,
                "_x": 50,
                "_width": 50,
                "_height": 100
            }
        ]
    }
    )");
}

@end
