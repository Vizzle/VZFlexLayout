//
//  SimpleTests.m
//  VZFlexLayout
//
//  Created by Sleen on 2017/8/8.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SimpleTests : XCTestCase

@end

@implementation SimpleTests

- (void)testSingle {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100
    }
    )");
}

- (void)testOneChild {
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 50,
                "height": 50
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
                "width": 10,
                "height": 10
            },
            {
                "width": 10,
                "height": 10,
                "_x": 10
            }
        ]
    }
    )");
}

@end
