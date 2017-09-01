//
//  Generated with W3C FlexBox test suites.
//
//  References:
//    W3C web-platform-tests: https://github.com/w3c/web-platform-tests
//    FlexBox test suites: https://github.com/w3c/web-platform-tests/tree/master/css/css-flexbox-1
//

#import <XCTest/XCTest.h>

@interface CSSFlexboxTests : XCTestCase

@end

@implementation CSSFlexboxTests

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-content-001.htm
- (void)test_align_content_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "align-content": "center",
        "wrap": "wrap",
        "children": [
            {
                "width": 150,
                "height": 26,
                "_y": 24
            },
            {
                "width": 150,
                "height": 26,
                "_x": 150,
                "_y": 24
            },
            {
                "width": 150,
                "height": 26,
                "_y": 50
            },
            {
                "width": 150,
                "height": 26,
                "_x": 150,
                "_y": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-content-002.htm
- (void)test_align_content_002 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "align-content": "start",
        "wrap": "wrap",
        "children": [
            {
                "width": 150,
                "height": 26
            },
            {
                "width": 150,
                "height": 26,
                "_x": 150
            },
            {
                "width": 150,
                "height": 26,
                "_y": 26
            },
            {
                "width": 150,
                "height": 26,
                "_x": 150,
                "_y": 26
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-content-003.htm
- (void)test_align_content_003 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "align-content": "end",
        "wrap": "wrap",
        "children": [
            {
                "width": 150,
                "height": 26,
                "_y": 48
            },
            {
                "width": 150,
                "height": 26,
                "_x": 150,
                "_y": 48
            },
            {
                "width": 150,
                "height": 26,
                "_y": 74
            },
            {
                "width": 150,
                "height": 26,
                "_x": 150,
                "_y": 74
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-content-004.htm
- (void)test_align_content_004 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "align-content": "space-between",
        "wrap": "wrap",
        "children": [
            {
                "width": 150,
                "height": 21
            },
            {
                "width": 150,
                "height": 21,
                "_x": 150
            },
            {
                "width": 150,
                "height": 21,
                "_y": 40
            },
            {
                "width": 150,
                "height": 21,
                "_x": 150,
                "_y": 40
            },
            {
                "width": 150,
                "height": 21,
                "_y": 79
            },
            {
                "width": 150,
                "height": 21,
                "_x": 150,
                "_y": 79
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-content-005.htm
- (void)test_align_content_005 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "align-content": "space-around",
        "wrap": "wrap",
        "children": [
            {
                "width": 150,
                "height": 22,
                "_y": 14
            },
            {
                "width": 150,
                "height": 22,
                "_x": 150,
                "_y": 14
            },
            {
                "width": 150,
                "height": 22,
                "_y": 64
            },
            {
                "width": 150,
                "height": 22,
                "_x": 150,
                "_y": 64
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-content-006.htm
- (void)test_align_content_006 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "align-content": "stretch",
        "wrap": "wrap",
        "children": [
            {
                "width": 150,
                "_height": 50
            },
            {
                "width": 150,
                "_x": 150,
                "_height": 50
            },
            {
                "width": 150,
                "_y": 50,
                "_height": 50
            },
            {
                "width": 150,
                "_x": 150,
                "_y": 50,
                "_height": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-content_center.html
- (void)test_align_content_center {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 80,
        "height": 200,
        "align-content": "center",
        "wrap": "wrap",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28,
                "_y": 25
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 75
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 125
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-content_flex-end.html
- (void)test_align_content_flex_end {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 80,
        "height": 200,
        "align-content": "end",
        "wrap": "wrap",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 100
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 150
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-content_flex-start.html
- (void)test_align_content_flex_start {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 80,
        "height": 200,
        "align-content": "start",
        "wrap": "wrap",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-content_space-around.html
- (void)test_align_content_space_around {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 80,
        "height": 200,
        "align-content": "space-around",
        "wrap": "wrap",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28,
                "_y": 8
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 75
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 142
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-content_space-between.html
- (void)test_align_content_space_between {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 80,
        "height": 200,
        "align-content": "space-between",
        "wrap": "wrap",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 75
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 150
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-content_stretch.html
- (void)test_align_content_stretch {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 80,
        "height": 200,
        "align-content": "stretch",
        "wrap": "wrap",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 67
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 133
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-items-001.htm
- (void)test_align_items_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "align-items": "center",
        "children": [
            {
                "width": 150,
                "height": 52,
                "_y": 24
            },
            {
                "width": 150,
                "height": 52,
                "_x": 150,
                "_y": 24
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-items-002.htm
- (void)test_align_items_002 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "align-items": "start",
        "children": [
            {
                "width": 150,
                "height": 51
            },
            {
                "width": 150,
                "height": 51,
                "_x": 150
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-items-003.htm
- (void)test_align_items_003 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "align-items": "end",
        "children": [
            {
                "width": 150,
                "height": 51,
                "_y": 49
            },
            {
                "width": 150,
                "height": 51,
                "_x": 150,
                "_y": 49
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-items-004.htm
- (void)test_align_items_004 {
    // TODO 'baseline' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "width": 300,
//        "height": 100,
//        "align-items": "baseline",
//        "wrap": "wrap",
//        "children": [
//            {
//                "width": 75,
//                "measure-width": 19.739974975585938,
//                "measure-height": 22,
//                "_y": 17,
//                "_height": 20
//            },
//            {
//                "width": 75,
//                "measure-width": 23.719985961914062,
//                "measure-height": 22,
//                "_x": 75,
//                "_y": 17,
//                "_height": 20
//            },
//            {
//                "width": 75,
//                "measure-width": 47.43998718261719,
//                "measure-height": 40,
//                "_x": 150,
//                "_height": 40
//            },
//            {
//                "width": 75,
//                "measure-width": 23.719985961914062,
//                "measure-height": 22,
//                "_x": 225,
//                "_y": 17,
//                "_height": 20
//            },
//            {
//                "width": 75,
//                "measure-width": 23.719985961914062,
//                "measure-height": 22,
//                "_y": 67,
//                "_height": 20
//            },
//            {
//                "width": 75,
//                "measure-width": 23.719985961914062,
//                "measure-height": 22,
//                "_x": 75,
//                "_y": 67,
//                "_height": 20
//            },
//            {
//                "width": 75,
//                "measure-width": 45.319976806640625,
//                "measure-height": 40,
//                "_x": 150,
//                "_y": 50,
//                "_height": 40
//            },
//            {
//                "width": 75,
//                "measure-width": 23.719985961914062,
//                "measure-height": 22,
//                "_x": 225,
//                "_y": 67,
//                "_height": 20
//            }
//        ]
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-items-005.htm
- (void)test_align_items_005 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "align-items": "stretch",
        "children": [
            {
                "width": 150,
                "_height": 100
            },
            {
                "width": 150,
                "_x": 150,
                "_height": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-items-006.html
- (void)test_align_items_006 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "align-items": "start",
        "direction": "vertical",
        "children": [
            {
                "measure-width": 127.39996337890625,
                "measure-height": 50,
                "_width": 127,
                "_height": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-001.html
- (void)test_align_self_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 25,
                "height": 50,
                "align-self": "start"
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "start",
                "_x": 25
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "start",
                "_x": 50
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "start",
                "_x": 75
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-002.html
- (void)test_align_self_002 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 25,
                "height": 50,
                "align-self": "end",
                "_y": 50
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "end",
                "_x": 25,
                "_y": 50
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "end",
                "_x": 50,
                "_y": 50
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "end",
                "_x": 75,
                "_y": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-003.html
- (void)test_align_self_003 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 25,
                "height": 50,
                "align-self": "center",
                "_y": 25
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "center",
                "_x": 25,
                "_y": 25
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "center",
                "_x": 50,
                "_y": 25
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "center",
                "_x": 75,
                "_y": 25
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-004.html
- (void)test_align_self_004 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "align-items": "center",
        "children": [
            {
                "width": 25,
                "align-self": "stretch",
                "_height": 100
            },
            {
                "width": 25,
                "align-self": "stretch",
                "_x": 25,
                "_height": 100
            },
            {
                "width": 25,
                "align-self": "stretch",
                "_x": 50,
                "_height": 100
            },
            {
                "width": 25,
                "align-self": "stretch",
                "_x": 75,
                "_height": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-005.html
- (void)test_align_self_005 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 25,
                "height": 50,
                "align-self": "stretch"
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "stretch",
                "_x": 25
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "stretch",
                "_x": 50
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "stretch",
                "_x": 75
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-006.html
- (void)test_align_self_006 {
    // TODO 'baseline' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "children": [
//            {
//                "width": 30,
//                "height": 90,
//                "align-self": "baseline",
//                "children": [
//                    {
//                        "measure-width": 33.53997802734375,
//                        "measure-height": 28,
//                        "_width": 34,
//                        "_height": 28
//                    }
//                ],
//                "_y": 11
//            },
//            {
//                "width": 30,
//                "height": 50,
//                "align-self": "baseline",
//                "children": [
//                    {
//                        "measure-width": 33.53996276855469,
//                        "measure-height": 17,
//                        "_width": 34,
//                        "_height": 17
//                    }
//                ],
//                "_x": 30,
//                "_y": 19
//            },
//            {
//                "width": 30,
//                "height": 100,
//                "align-self": "baseline",
//                "children": [
//                    {
//                        "measure-width": 33.53997802734375,
//                        "measure-height": 42,
//                        "_width": 34,
//                        "_height": 42
//                    }
//                ],
//                "_x": 60
//            },
//            {
//                "width": 30,
//                "height": 80,
//                "align-self": "baseline",
//                "children": [
//                    {
//                        "measure-width": 25.154983520507812,
//                        "measure-height": 21,
//                        "_width": 25,
//                        "_height": 21
//                    }
//                ],
//                "_x": 90,
//                "_y": 16
//            }
//        ],
//        "_width": 1000,
//        "_height": 101
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-007.html
- (void)test_align_self_007 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "align-items": "start",
        "children": [
            {
                "width": 25,
                "height": 50,
                "align-self": "auto"
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "auto",
                "_x": 25
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "auto",
                "_x": 50
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "auto",
                "_x": 75
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-008.html
- (void)test_align_self_008 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "align-items": "end",
        "children": [
            {
                "width": 25,
                "height": 50,
                "align-self": "auto",
                "_y": 50
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "auto",
                "_x": 25,
                "_y": 50
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "auto",
                "_x": 50,
                "_y": 50
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "auto",
                "_x": 75,
                "_y": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-009.html
- (void)test_align_self_009 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "align-items": "center",
        "children": [
            {
                "width": 25,
                "height": 50,
                "align-self": "auto",
                "_y": 25
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "auto",
                "_x": 25,
                "_y": 25
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "auto",
                "_x": 50,
                "_y": 25
            },
            {
                "width": 25,
                "height": 50,
                "align-self": "auto",
                "_x": 75,
                "_y": 25
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-010.html
- (void)test_align_self_010 {
    // TODO 'baseline' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "align-items": "baseline",
//        "children": [
//            {
//                "width": 30,
//                "height": 90,
//                "align-self": "auto",
//                "children": [
//                    {
//                        "measure-width": 33.53997802734375,
//                        "measure-height": 28,
//                        "_width": 34,
//                        "_height": 28
//                    }
//                ],
//                "_y": 11
//            },
//            {
//                "width": 30,
//                "height": 50,
//                "align-self": "auto",
//                "children": [
//                    {
//                        "measure-width": 33.53996276855469,
//                        "measure-height": 17,
//                        "_width": 34,
//                        "_height": 17
//                    }
//                ],
//                "_x": 30,
//                "_y": 19
//            },
//            {
//                "width": 30,
//                "height": 100,
//                "align-self": "auto",
//                "children": [
//                    {
//                        "measure-width": 33.53997802734375,
//                        "measure-height": 42,
//                        "_width": 34,
//                        "_height": 42
//                    }
//                ],
//                "_x": 60
//            },
//            {
//                "width": 30,
//                "height": 80,
//                "align-self": "auto",
//                "children": [
//                    {
//                        "measure-width": 25.154983520507812,
//                        "measure-height": 21,
//                        "_width": 25,
//                        "_height": 21
//                    }
//                ],
//                "_x": 90,
//                "_y": 16
//            }
//        ],
//        "_width": 1000,
//        "_height": 101
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-011.html
- (void)test_align_self_011 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "align-items": "stretch",
        "children": [
            {
                "width": 25,
                "align-self": "auto",
                "_height": 100
            },
            {
                "width": 25,
                "align-self": "auto",
                "_x": 25,
                "_height": 100
            },
            {
                "width": 25,
                "align-self": "auto",
                "_x": 50,
                "_height": 100
            },
            {
                "width": 25,
                "align-self": "auto",
                "_x": 75,
                "_height": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-012.html
- (void)test_align_self_012 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "align-items": "stretch",
        "children": [
            {
                "width": 25,
                "align-self": "auto",
                "_height": 100
            },
            {
                "width": 25,
                "align-self": "auto",
                "_x": 25,
                "_height": 100
            },
            {
                "width": 25,
                "_x": 50,
                "_height": 100
            },
            {
                "width": 25,
                "_x": 75,
                "_height": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/align-self-013.html
- (void)test_align_self_013 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "align-items": "start",
        "align-self": "end",
        "children": [
            {
                "width": 25,
                "height": 50
            },
            {
                "width": 25,
                "height": 50,
                "_x": 25
            },
            {
                "width": 25,
                "height": 50,
                "_x": 50
            },
            {
                "width": 25,
                "height": 50,
                "_x": 75
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-box-justify-content.html
- (void)test_css_box_justify_content {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 40,
        "justify-content": "end",
        "wrap": "initial",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 30,
                "measure-width": 31.72796630859375,
                "measure-height": 22,
                "_x": 50
            },
            {
                "width": 50,
                "height": 30,
                "measure-width": 34.91197204589844,
                "measure-height": 22,
                "_x": 100
            },
            {
                "width": 50,
                "height": 30,
                "measure-width": 34.91197204589844,
                "measure-height": 22,
                "_x": 150
            },
            {
                "width": 50,
                "height": 30,
                "measure-width": 34.91197204589844,
                "measure-height": 22,
                "_x": 200
            },
            {
                "width": 50,
                "height": 30,
                "measure-width": 34.91197204589844,
                "measure-height": 22,
                "_x": 250
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-column-reverse-wrap-reverse.html
- (void)test_css_flexbox_column_reverse_wrap_reverse {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "width": 144,
//        "min-height": 64,
//        "align-content": "end",
//        "wrap": "wrap-reverse",
//        "direction": "vertical-reverse",
//        "children": [
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 48,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 72,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 96,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 120,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 48,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 72,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 96,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 120,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 24
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 48
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 72
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 96
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 120
//            }
//        ],
//        "_height": 64
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-column-reverse-wrap.html
- (void)test_css_flexbox_column_reverse_wrap {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "width": 144,
//        "min-height": 64,
//        "align-content": "start",
//        "wrap": "wrap",
//        "direction": "vertical-reverse",
//        "children": [
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 24
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 48
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 72
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 96
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 120
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 48,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 72,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 96,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 120,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 48,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 72,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 96,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 120,
//                "_y": 32
//            }
//        ],
//        "_height": 64
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-column-reverse.html
- (void)test_css_flexbox_column_reverse {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "width": 144,
//        "wrap": "initial",
//        "direction": "vertical-reverse",
//        "children": [
//            {
//                "width": 24,
//                "height": 64,
//                "measure-width": 48,
//                "measure-height": 22
//            },
//            {
//                "width": 24,
//                "height": 64,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24
//            },
//            {
//                "width": 24,
//                "height": 64,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 48
//            },
//            {
//                "width": 24,
//                "height": 64,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 72
//            },
//            {
//                "width": 24,
//                "height": 64,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 96
//            },
//            {
//                "width": 24,
//                "height": 64,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 120
//            }
//        ],
//        "_height": 64
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-column-wrap-reverse.html
- (void)test_css_flexbox_column_wrap_reverse {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "width": 144,
//        "min-height": 64,
//        "align-content": "end",
//        "wrap": "wrap-reverse",
//        "direction": "vertical",
//        "children": [
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 120,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 96,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 72,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 48,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 120,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 96,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 72,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 48,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 120
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 96
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 72
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 48
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 24
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22
//            }
//        ],
//        "_height": 64
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-column-wrap.html
- (void)test_css_flexbox_column_wrap {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "width": 144,
//        "min-height": 64,
//        "align-content": "start",
//        "wrap": "wrap",
//        "direction": "vertical",
//        "children": [
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 120
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 96
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 72
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 48
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 24
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 120,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 96,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 72,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 48,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_y": 16
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 120,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 96,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 72,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 48,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 32
//            },
//            {
//                "width": 24,
//                "height": 16,
//                "measure-width": 16,
//                "measure-height": 22,
//                "_y": 32
//            }
//        ],
//        "_height": 64
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-column.html
- (void)test_css_flexbox_column {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "width": 144,
//        "wrap": "initial",
//        "direction": "vertical",
//        "children": [
//            {
//                "width": 24,
//                "height": 64,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 120
//            },
//            {
//                "width": 24,
//                "height": 64,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 96
//            },
//            {
//                "width": 24,
//                "height": 64,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 72
//            },
//            {
//                "width": 24,
//                "height": 64,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 48
//            },
//            {
//                "width": 24,
//                "height": 64,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24
//            },
//            {
//                "width": 24,
//                "height": 64,
//                "measure-width": 48,
//                "measure-height": 22
//            }
//        ],
//        "_height": 64
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-height-animation-stretch.html
- (void)test_css_flexbox_height_animation_stretch {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-img-expand-evenly.html
- (void)test_css_flexbox_img_expand_evenly {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 50,
        "children": [
            {
                "width": 48,
                "flex-grow": 1,
                "_width": 100,
                "_height": 50
            },
            {
                "width": 48,
                "flex-grow": 1,
                "_x": 100,
                "_width": 100,
                "_height": 50
            },
            {
                "width": 48,
                "flex-grow": 1,
                "_x": 200,
                "_width": 100,
                "_height": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-row-reverse-wrap-reverse.html
- (void)test_css_flexbox_row_reverse_wrap_reverse {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "height": 144,
//        "wrap": "wrap-reverse",
//        "direction": "horizontal-reverse",
//        "children": [
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_y": 96
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_y": 48
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 96
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 48
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24
//            }
//        ],
//        "_width": 48
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-row-reverse-wrap.html
- (void)test_css_flexbox_row_reverse_wrap {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "height": 144,
//        "wrap": "wrap",
//        "direction": "horizontal-reverse",
//        "children": [
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 96
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 48
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_y": 96
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_y": 48
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22
//            }
//        ],
//        "_width": 48
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-row-reverse.html
- (void)test_css_flexbox_row_reverse {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "wrap": "initial",
//        "direction": "horizontal-reverse",
//        "children": [
//            {
//                "width": 48,
//                "height": 48,
//                "children": [
//                    {
//                        "_x": 25,
//                        "_y": 48,
//                        "_width": 22,
//                        "_height": 0
//                    }
//                ],
//                "_y": 96
//            },
//            {
//                "width": 48,
//                "height": 48,
//                "children": [
//                    {
//                        "_x": 25,
//                        "_y": 48,
//                        "_width": 22,
//                        "_height": 0
//                    }
//                ],
//                "_y": 48
//            },
//            {
//                "width": 48,
//                "height": 48,
//                "children": [
//                    {
//                        "_x": 25,
//                        "_y": 48,
//                        "_width": 22,
//                        "_height": 0
//                    }
//                ]
//            }
//        ],
//        "_width": 48,
//        "_height": 144
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-row-wrap-reverse.html
- (void)test_css_flexbox_row_wrap_reverse {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "height": 144,
//        "wrap": "wrap-reverse",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_y": 48
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_y": 96
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 48
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 96
//            }
//        ],
//        "_width": 48
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-row-wrap.html
- (void)test_css_flexbox_row_wrap {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "height": 144,
//        "wrap": "wrap",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 48
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_x": 24,
//                "_y": 96
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_y": 48
//            },
//            {
//                "width": 24,
//                "height": 48,
//                "measure-width": 48,
//                "measure-height": 22,
//                "_y": 96
//            }
//        ],
//        "_width": 48
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-row.html
- (void)test_css_flexbox_row {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "wrap": "initial",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 48,
//                "height": 48,
//                "children": [
//                    {
//                        "_x": 25,
//                        "_y": 48,
//                        "_width": 22,
//                        "_height": 0
//                    }
//                ]
//            },
//            {
//                "width": 48,
//                "height": 48,
//                "children": [
//                    {
//                        "_x": 25,
//                        "_y": 48,
//                        "_width": 22,
//                        "_height": 0
//                    }
//                ],
//                "_y": 48
//            },
//            {
//                "width": 48,
//                "height": 48,
//                "children": [
//                    {
//                        "_x": 25,
//                        "_y": 48,
//                        "_width": 22,
//                        "_height": 0
//                    }
//                ],
//                "_y": 96
//            }
//        ],
//        "_width": 48,
//        "_height": 144
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/css-flexbox-test1.html
- (void)test_css_flexbox_test1 {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "wrap": "initial",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 48,
//                "height": 48,
//                "children": [
//                    {
//                        "_x": 26,
//                        "_y": 48,
//                        "_width": 22,
//                        "_height": 0
//                    }
//                ]
//            },
//            {
//                "width": 48,
//                "height": 48,
//                "children": [
//                    {
//                        "_x": 26,
//                        "_y": 48,
//                        "_width": 22,
//                        "_height": 0
//                    }
//                ],
//                "_y": 48
//            },
//            {
//                "width": 48,
//                "height": 48,
//                "children": [
//                    {
//                        "_x": 26,
//                        "_y": 48,
//                        "_width": 22,
//                        "_height": 0
//                    }
//                ],
//                "_y": 96
//            }
//        ],
//        "_width": 48,
//        "_height": 144
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/display-flex-001.htm
- (void)test_display_flex_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "children": [
            {
                "width": 150,
                "_height": 100
            },
            {
                "width": 150,
                "_x": 150,
                "_height": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-001.htm
- (void)test_flex_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "children": [
            {
                "height": 100,
                "flex-basis": "auto",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 150
            },
            {
                "height": 100,
                "flex-basis": "auto",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 150,
                "_width": 150
            }
        ],
        "_height": 100
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-002.htm
- (void)test_flex_002 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 50,
        "children": [
            {
                "width": 300,
                "height": 50,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 2,
                "_width": 150
            },
            {
                "width": 200,
                "height": 50,
                "_x": 150,
                "_width": 150
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-003.htm
- (void)test_flex_003 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 50,
        "children": [
            {
                "width": 100,
                "height": 50,
                "flex-basis": "auto",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 150
            },
            {
                "width": 50,
                "height": 50,
                "flex-basis": "auto",
                "flex-grow": 2,
                "flex-shrink": 0,
                "_x": 150,
                "_width": 150
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-004.htm
- (void)test_flex_004 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 50,
        "children": [
            {
                "width": 300,
                "height": 50,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 2,
                "_width": 150
            },
            {
                "width": 600,
                "height": 50,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 3,
                "_x": 150,
                "_width": 150
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-align-items-center.html
- (void)test_flex_align_items_center {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 600,
        "height": 200,
        "top": 70,
        "left": 10,
        "padding-top": 5,
        "padding-right": 5,
        "padding-bottom": 5,
        "padding-left": 5,
        "align-items": "center",
        "justify-content": "center",
        "children": [
            {
                "width": 30,
                "height": 40,
                "flex-basis": "auto",
                "padding-top": 10,
                "padding-right": 10,
                "padding-bottom": 10,
                "padding-left": 10,
                "flex-grow": 0,
                "flex-shrink": 0,
                "_x": 255,
                "_y": 80
            },
            {
                "width": 30,
                "height": 40,
                "flex-basis": "auto",
                "padding-top": 10,
                "padding-right": 10,
                "padding-bottom": 10,
                "padding-left": 10,
                "flex-grow": 0,
                "flex-shrink": 0,
                "_x": 285,
                "_y": 80
            },
            {
                "width": 30,
                "height": 40,
                "flex-basis": "auto",
                "padding-top": 10,
                "padding-right": 10,
                "padding-bottom": 10,
                "padding-left": 10,
                "flex-grow": 0,
                "flex-shrink": 0,
                "_x": 315,
                "_y": 80
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-basis-001.html
- (void)test_flex_basis_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "height": 100,
                "flex-basis": 60,
                "_width": 60
            },
            {
                "width": 40,
                "height": 100,
                "_x": 60
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-basis-002.html
- (void)test_flex_basis_002 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 80,
                "height": 100,
                "flex-basis": 60,
                "_width": 60
            },
            {
                "width": 40,
                "height": 100,
                "_x": 60
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-basis-003.html
- (void)test_flex_basis_003 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "height": 100,
                "_width": 0
            },
            {
                "width": 50,
                "height": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-basis-004.html
- (void)test_flex_basis_004 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 30,
                "height": 100
            },
            {
                "width": 50,
                "height": 100,
                "_x": 30
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-basis-005.html
- (void)test_flex_basis_005 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 100,
                "height": 100,
                "flex-basis": 0,
                "_width": 0
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-basis-006.html
- (void)test_flex_basis_006 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 100,
                "height": 100,
                "flex-basis": "0%",
                "_width": 0
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-basis-007.html
- (void)test_flex_basis_007 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 50,
                "height": 100,
                "flex-basis": "auto"
            },
            {
                "width": 50,
                "height": 100,
                "_x": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-basis-008.html
- (void)test_flex_basis_008 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 40,
                "height": 100
            },
            {
                "height": 100,
                "flex-basis": "60%",
                "_x": 40,
                "_width": 60
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-box-wrap.html
- (void)test_flex_box_wrap {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "wrap": "wrap",
        "children": [
            {
                "width": 120,
                "height": 100,
                "measure-width": 92.81590270996094,
                "measure-height": 22
            },
            {
                "width": 120,
                "height": 100,
                "measure-width": 92.81590270996094,
                "measure-height": 22,
                "_y": 100
            }
        ],
        "_height": 200
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-container-margin.html
- (void)test_flex_container_margin {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 20,
        "margin-right": 20,
        "margin-bottom": 20,
        "margin-left": 20,
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "_x": 20,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "_x": 110,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "_x": 200,
                "_y": 20
            }
        ],
        "_x": 20,
        "_y": 20,
        "_width": 960,
        "_height": 90
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-direction-column-reverse.html
- (void)test_flex_direction_column_reverse {
    XCTAssertLayoutWithConfig(FlexAuto, FlexAuto, 1, @R"(
    {
        "height": 48,
        "direction": "vertical",
        "children": [
            {
                "height": 16,
                "measure-width": 10.511993408203125,
                "measure-height": 22,
                "_width": 12
            },
            {
                "height": 16,
                "measure-width": 10.831985473632812,
                "measure-height": 22,
                "_y": 16,
                "_width": 12
            },
            {
                "height": 16,
                "measure-width": 11.647994995117188,
                "measure-height": 22,
                "_y": 32,
                "_width": 12
            }
        ],
        "_width": 12
    }
    )");

    XCTAssertLayoutWithConfig(FlexAuto, FlexAuto, 1, @R"(
    {
        "height": 48,
        "direction": "vertical-reverse",
        "children": [
            {
                "height": 16,
                "measure-width": 11.647994995117188,
                "measure-height": 22,
                "_y": 32,
                "_width": 12
            },
            {
                "height": 16,
                "measure-width": 10.831985473632812,
                "measure-height": 22,
                "_y": 16,
                "_width": 12
            },
            {
                "height": 16,
                "measure-width": 10.511993408203125,
                "measure-height": 22,
                "_width": 12
            }
        ],
        "_width": 12
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-direction-modify.html
- (void)test_flex_direction_modify {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 20,
        "margin-right": 20,
        "margin-bottom": 20,
        "margin-left": 20,
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_x": 20,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 110,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 200,
                "_y": 20
            }
        ],
        "_x": 20,
        "_y": 20,
        "_width": 960,
        "_height": 90
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-direction-row-reverse.html
- (void)test_flex_direction_row_reverse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 48,
        "direction": "horizontal",
        "children": [
            {
                "width": 16,
                "measure-width": 10.511993408203125,
                "measure-height": 22,
                "_height": 22
            },
            {
                "width": 16,
                "measure-width": 10.831985473632812,
                "measure-height": 22,
                "_x": 16,
                "_height": 22
            },
            {
                "width": 16,
                "measure-width": 11.647994995117188,
                "measure-height": 22,
                "_x": 32,
                "_height": 22
            }
        ],
        "_height": 22
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 48,
        "direction": "horizontal-reverse",
        "children": [
            {
                "width": 16,
                "measure-width": 11.647994995117188,
                "measure-height": 22,
                "_x": 32,
                "_height": 22
            },
            {
                "width": 16,
                "measure-width": 10.831985473632812,
                "measure-height": 22,
                "_x": 16,
                "_height": 22
            },
            {
                "width": 16,
                "measure-width": 10.511993408203125,
                "measure-height": 22,
                "_height": 22
            }
        ],
        "_height": 22
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-direction-row-vertical.html
- (void)test_flex_direction_row_vertical {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-direction-with-element-insert.html
- (void)test_flex_direction_with_element_insert {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 20,
        "margin-right": 20,
        "margin-bottom": 20,
        "margin-left": 20,
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_x": 20,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 110,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 200,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 29.903976440429688,
                "measure-height": 22,
                "_x": 290,
                "_y": 20
            }
        ],
        "_x": 20,
        "_y": 20,
        "_width": 960,
        "_height": 90
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 20,
        "margin-right": 20,
        "margin-bottom": 20,
        "margin-left": 20,
        "direction": "horizontal-reverse",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_x": 890,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 800,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 710,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 29.903976440429688,
                "measure-height": 22,
                "_x": 620,
                "_y": 20
            }
        ],
        "_x": 20,
        "_y": 20,
        "_width": 960,
        "_height": 90
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 20,
        "margin-right": 20,
        "margin-bottom": 20,
        "margin-left": 20,
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_x": 20,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 20,
                "_y": 110
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 20,
                "_y": 200
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 29.903976440429688,
                "measure-height": 22,
                "_x": 20,
                "_y": 290
            }
        ],
        "_x": 20,
        "_y": 20,
        "_width": 960,
        "_height": 360
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 20,
        "margin-right": 20,
        "margin-bottom": 20,
        "margin-left": 20,
        "direction": "vertical-reverse",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_x": 20,
                "_y": 290
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 20,
                "_y": 200
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 20,
                "_y": 110
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 29.903976440429688,
                "measure-height": 22,
                "_x": 20,
                "_y": 20
            }
        ],
        "_x": 20,
        "_y": 20,
        "_width": 960,
        "_height": 360
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-direction.html
- (void)test_flex_direction {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 20,
        "margin-right": 20,
        "margin-bottom": 20,
        "margin-left": 20,
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_x": 20,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 110,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 200,
                "_y": 20
            }
        ],
        "_x": 20,
        "_y": 20,
        "_width": 960,
        "_height": 90
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 20,
        "margin-right": 20,
        "margin-bottom": 20,
        "margin-left": 20,
        "direction": "horizontal-reverse",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_x": 890,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 800,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 710,
                "_y": 20
            }
        ],
        "_x": 20,
        "_y": 20,
        "_width": 960,
        "_height": 90
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 20,
        "margin-right": 20,
        "margin-bottom": 20,
        "margin-left": 20,
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_x": 20,
                "_y": 20
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 20,
                "_y": 110
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 20,
                "_y": 200
            }
        ],
        "_x": 20,
        "_y": 20,
        "_width": 960,
        "_height": 270
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 20,
        "margin-right": 20,
        "margin-bottom": 20,
        "margin-left": 20,
        "direction": "vertical-reverse",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_x": 20,
                "_y": 200
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 20,
                "_y": 110
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 20,
                "_y": 20
            }
        ],
        "_x": 20,
        "_y": 20,
        "_width": 960,
        "_height": 270
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-direction_column-reverse.html
- (void)test_flex_direction_column_reverse_1 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "height": 200,
        "direction": "vertical-reverse",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28,
                "_y": 150
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 100
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-direction_column.html
- (void)test_flex_direction_column {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "height": 200,
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-direction_row-reverse.html
- (void)test_flex_direction_row_reverse_1 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "height": 200,
        "direction": "horizontal-reverse",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28,
                "_x": 150
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 100
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-direction_row.html
- (void)test_flex_direction_row {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "height": 200,
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flexitem-childmargin.html
- (void)test_flex_flexitem_childmargin {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "height": 300,
        "children": [
            {
                "height": 300,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "children": [
                    {
                        "width": 100,
                        "height": 100,
                        "margin-top": 200,
                        "measure-width": 147.4716796875,
                        "measure-height": 22,
                        "_y": 200
                    }
                ],
                "_width": 900
            },
            {
                "width": 100,
                "children": [
                    {
                        "width": 100,
                        "height": 100,
                        "margin-top": 200,
                        "measure-width": 147.90367126464844,
                        "measure-height": 22,
                        "_y": 200
                    }
                ],
                "_x": 900,
                "_height": 300
            }
        ],
        "_width": 1000
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flexitem-percentage-prescation.html
- (void)test_flex_flexitem_percentage_prescation {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 101,
        "height": 300,
        "children": [
            {
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_width": 51,
                "_height": 300
            },
            {
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 51,
                "_width": 50,
                "_height": 300
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flow-001.html
- (void)test_flex_flow_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "wrap": "nowrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_width": 25
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 25,
                "_width": 25
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50,
                "_width": 25
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 75,
                "_width": 25
            }
        ],
        "_height": 50
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flow-002.html
- (void)test_flex_flow_002 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 6.415985107421875,
                "measure-height": 22
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50,
                "_y": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flow-003.html
- (void)test_flex_flow_003 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "wrap": "wrap-reverse",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 6.415985107421875,
                "measure-height": 22
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flow-004.html
- (void)test_flex_flow_004 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "wrap": "nowrap",
        "direction": "horizontal-reverse",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 75,
                "_width": 25
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50,
                "_width": 25
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 25,
                "_width": 25
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_width": 25
            }
        ],
        "_height": 50
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flow-005.html
- (void)test_flex_flow_005 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "wrap": "wrap",
        "direction": "horizontal-reverse",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 6.415985107421875,
                "measure-height": 22
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flow-006.html
- (void)test_flex_flow_006 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "wrap": "wrap-reverse",
        "direction": "horizontal-reverse",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 6.415985107421875,
                "measure-height": 22
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flow-007.html
- (void)test_flex_flow_007 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "wrap": "nowrap",
        "direction": "vertical",
        "children": [
            {
                "height": 50,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_width": 100,
                "_height": 25
            },
            {
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 25,
                "_width": 100,
                "_height": 25
            },
            {
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 50,
                "_width": 100,
                "_height": 25
            },
            {
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 75,
                "_width": 100,
                "_height": 25
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flow-008.html
- (void)test_flex_flow_008 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 6.415985107421875,
                "measure-height": 22
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50,
                "_y": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flow-009.html
- (void)test_flex_flow_009 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "wrap": "wrap-reverse",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 6.415985107421875,
                "measure-height": 22
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flow-010.html
- (void)test_flex_flow_010 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "wrap": "nowrap",
        "direction": "vertical-reverse",
        "children": [
            {
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 75,
                "_width": 100,
                "_height": 25
            },
            {
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 50,
                "_width": 100,
                "_height": 25
            },
            {
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 25,
                "_width": 100,
                "_height": 25
            },
            {
                "height": 50,
                "measure-width": 6.415985107421875,
                "measure-height": 22,
                "_width": 100,
                "_height": 25
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flow-011.html
- (void)test_flex_flow_011 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "wrap": "wrap",
        "direction": "vertical-reverse",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 6.415985107421875,
                "measure-height": 22
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-flow-012.html
- (void)test_flex_flow_012 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "wrap": "wrap-reverse",
        "direction": "vertical-reverse",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_x": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 9.599990844726562,
                "measure-height": 22,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 6.415985107421875,
                "measure-height": 22
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-grow-001.xht
- (void)test_flex_grow_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 240,
        "height": 60,
        "children": [
            {
                "width": 30,
                "height": "100%",
                "flex-grow": 0,
                "_height": 60
            },
            {
                "width": 30,
                "height": "100%",
                "flex-grow": 1,
                "_x": 30,
                "_width": 80,
                "_height": 60
            },
            {
                "width": 30,
                "height": "100%",
                "flex-grow": 2,
                "_x": 110,
                "_width": 130,
                "_height": 60
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-grow-002.html
- (void)test_flex_grow_002 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 20,
                "height": 100,
                "flex-grow": 1,
                "_width": 60
            },
            {
                "width": 20,
                "height": 100,
                "flex-grow": 0,
                "_x": 60
            },
            {
                "width": 20,
                "height": 100,
                "_x": 80
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-grow-003.html
- (void)test_flex_grow_003 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 25,
                "height": 100
            },
            {
                "width": 25,
                "height": 100,
                "_x": 25
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-grow-004.html
- (void)test_flex_grow_004 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 50,
                "height": 100,
                "flex-grow": 3
            },
            {
                "width": 50,
                "height": 100,
                "flex-grow": 2,
                "_x": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-grow-005.html
- (void)test_flex_grow_005 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "flex-grow": 2,
        "children": [
            {
                "width": 25,
                "height": 100
            },
            {
                "width": 25,
                "height": 100,
                "_x": 25
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-grow-006.html
- (void)test_flex_grow_006 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 50,
        "children": [
            {
                "width": 25,
                "height": 50,
                "flex-grow": 1.5,
                "_width": 100
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 50,
        "children": [
            {
                "width": 25,
                "height": 50,
                "flex-grow": 2,
                "_width": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-grow-007.html
- (void)test_flex_grow_007 {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-items-flexibility.html
- (void)test_flex_items_flexibility {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 600,
        "height": 200,
        "top": 70,
        "left": 10,
        "padding-top": 5,
        "padding-right": 5,
        "padding-bottom": 5,
        "padding-left": 5,
        "align-items": "center",
        "justify-content": "center",
        "children": [
            {
                "width": 30,
                "height": 40,
                "flex-basis": "auto",
                "padding-top": 10,
                "padding-right": 10,
                "padding-bottom": 10,
                "padding-left": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 5,
                "_y": 80,
                "_width": 155
            },
            {
                "width": 30,
                "height": 40,
                "flex-basis": "auto",
                "padding-top": 10,
                "padding-right": 10,
                "padding-bottom": 10,
                "padding-left": 10,
                "flex-grow": 2,
                "flex-shrink": 0,
                "_x": 160,
                "_y": 80,
                "_width": 280
            },
            {
                "width": 30,
                "height": 40,
                "flex-basis": "auto",
                "padding-top": 10,
                "padding-right": 10,
                "padding-bottom": 10,
                "padding-left": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 440,
                "_y": 80,
                "_width": 155
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-margin-no-collapse.html
- (void)test_flex_margin_no_collapse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "height": 300,
        "top": 100,
        "left": 10,
        "direction": "vertical",
        "children": [
            {
                "width": 100,
                "height": 100,
                "flex-basis": "auto",
                "margin-top": 50,
                "margin-bottom": 50,
                "flex-grow": 0,
                "flex-shrink": 0,
                "_y": 50
            },
            {
                "width": 100,
                "height": 100,
                "flex-basis": "auto",
                "margin-top": 50,
                "margin-bottom": 50,
                "flex-grow": 0,
                "flex-shrink": 0,
                "_y": 250
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-shrink-001.html
- (void)test_flex_shrink_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 100,
                "height": 100,
                "flex-shrink": 2,
                "_width": 60
            },
            {
                "width": 100,
                "height": 100,
                "flex-shrink": 3,
                "_x": 60,
                "_width": 40
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-shrink-002.html
- (void)test_flex_shrink_002 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 100,
                "height": 100,
                "_width": 50
            },
            {
                "width": 100,
                "height": 100,
                "_x": 50,
                "_width": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-shrink-003.html
- (void)test_flex_shrink_003 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 100,
                "height": 100,
                "_width": 80
            },
            {
                "width": 100,
                "height": 100,
                "flex-shrink": 4,
                "_x": 80,
                "_width": 20
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-shrink-004.html
- (void)test_flex_shrink_004 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 40,
                "height": 100,
                "flex-shrink": 2
            },
            {
                "width": 40,
                "height": 100,
                "flex-shrink": 3,
                "_x": 40
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-shrink-005.html
- (void)test_flex_shrink_005 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 50,
        "height": 100,
        "children": [
            {
                "width": 50,
                "height": 100,
                "flex-shrink": 0
            },
            {
                "width": 50,
                "height": 100,
                "flex-shrink": 0,
                "_x": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-shrink-006.html
- (void)test_flex_shrink_006 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "children": [
            {
                "width": 100,
                "height": 100,
                "flex-shrink": 0
            },
            {
                "width": 100,
                "height": 100,
                "flex-shrink": 3,
                "_x": 100,
                "_width": 0
            },
            {
                "width": 100,
                "height": 100,
                "flex-shrink": 2,
                "_x": 100,
                "_width": 0
            },
            {
                "width": 100,
                "height": 100,
                "_x": 100,
                "_width": 0
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-shrink-007.html
- (void)test_flex_shrink_007 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 2,
        "children": [
            {
                "width": 100,
                "height": 100,
                "_width": 50
            },
            {
                "width": 100,
                "height": 100,
                "_x": 50,
                "_width": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-shrink-008.html
- (void)test_flex_shrink_008 {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-wrap-001.htm
- (void)test_flex_wrap_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "wrap": "wrap",
        "children": [
            {
                "width": 150,
                "_height": 50
            },
            {
                "width": 150,
                "_x": 150,
                "_height": 50
            },
            {
                "width": 150,
                "_y": 50,
                "_height": 50
            },
            {
                "width": 150,
                "_x": 150,
                "_y": 50,
                "_height": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-wrap_nowrap.html
- (void)test_flex_wrap_nowrap {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 120,
        "wrap": "nowrap",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28,
                "_width": 40
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 40,
                "_width": 40
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 80,
                "_width": 40
            }
        ],
        "_height": 50
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-wrap_wrap-reverse.html
- (void)test_flex_wrap_wrap_reverse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 120,
        "wrap": "wrap-reverse",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 50,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28
            }
        ],
        "_height": 100
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flex-wrap_wrap.html
- (void)test_flex_wrap_wrap {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 120,
        "wrap": "wrap",
        "children": [
            {
                "width": 50,
                "height": 50,
                "measure-width": 8.019989013671875,
                "measure-height": 28
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 50
            },
            {
                "width": 50,
                "height": 50,
                "measure-width": 12,
                "measure-height": 28,
                "_y": 50
            }
        ],
        "_height": 100
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox-flex-direction-column-reverse.htm
- (void)test_flexbox_flex_direction_column_reverse {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "horizontal-tb",
//        "width": 120,
//        "height": 120,
//        "wrap": "wrap",
//        "direction": "vertical-reverse",
//        "children": [
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 8.751998901367188,
//                "measure-height": 22,
//                "_y": 82
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_y": 44
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 6.415985107421875,
//                "measure-height": 22,
//                "_y": 6
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 40,
//                "_y": 82
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 40,
//                "_y": 44
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 40,
//                "_y": 6
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 80,
//                "_y": 82
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 80,
//                "_y": 44
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 80,
//                "_y": 6
//            }
//        ]
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox-flex-direction-column.htm
- (void)test_flexbox_flex_direction_column {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "horizontal-tb",
//        "width": 120,
//        "height": 120,
//        "wrap": "wrap",
//        "direction": "vertical",
//        "children": [
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 6.415985107421875,
//                "measure-height": 22
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_y": 38
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 8.751998901367188,
//                "measure-height": 22,
//                "_y": 76
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 40,
//                "_y": 38
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 40,
//                "_y": 76
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 80
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 80,
//                "_y": 38
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 80,
//                "_y": 76
//            }
//        ]
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox-flex-direction-default.htm
- (void)test_flexbox_flex_direction_default {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "horizontal-tb",
//        "width": 120,
//        "height": 120,
//        "wrap": "wrap",
//        "children": [
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 6.415985107421875,
//                "measure-height": 22
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 38
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 76
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_y": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 38,
//                "_y": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 76,
//                "_y": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 8.751998901367188,
//                "measure-height": 22,
//                "_y": 80
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 38,
//                "_y": 80
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 76,
//                "_y": 80
//            }
//        ]
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox-flex-direction-row-reverse.htm
- (void)test_flexbox_flex_direction_row_reverse {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "horizontal-tb",
//        "width": 120,
//        "height": 120,
//        "wrap": "wrap",
//        "direction": "horizontal-reverse",
//        "children": [
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 82
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 44
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 6.415985107421875,
//                "measure-height": 22,
//                "_x": 6
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 82,
//                "_y": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 44,
//                "_y": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 6,
//                "_y": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 82,
//                "_y": 80
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 44,
//                "_y": 80
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 8.751998901367188,
//                "measure-height": 22,
//                "_x": 6,
//                "_y": 80
//            }
//        ]
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox-flex-direction-row.htm
- (void)test_flexbox_flex_direction_row {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "horizontal-tb",
//        "width": 120,
//        "height": 120,
//        "wrap": "wrap",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 6.415985107421875,
//                "measure-height": 22
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 38
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 76
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_y": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 38,
//                "_y": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 76,
//                "_y": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 8.751998901367188,
//                "measure-height": 22,
//                "_y": 80
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 38,
//                "_y": 80
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 76,
//                "_y": 80
//            }
//        ]
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox-flex-wrap-default.htm
- (void)test_flexbox_flex_wrap_default {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 60,
        "height": 120,
        "children": [
            {
                "width": 60,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "_height": 120
            },
            {
                "width": 60,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "_x": 60,
                "_height": 120
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox-flex-wrap-flexing.html
- (void)test_flexbox_flex_wrap_flexing {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 150,
        "height": 100,
        "wrap": "wrap",
        "children": [
            {
                "height": 50,
                "min-width": 100,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "_width": 150
            },
            {
                "height": 50,
                "min-width": 100,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "_y": 50,
                "_width": 150
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox-flex-wrap-nowrap.htm
- (void)test_flexbox_flex_wrap_nowrap {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 60,
        "height": 120,
        "wrap": "nowrap",
        "children": [
            {
                "width": 60,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "_height": 120
            },
            {
                "width": 60,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "_x": 60,
                "_height": 120
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox-flex-wrap-wrap-reverse.htm
- (void)test_flexbox_flex_wrap_wrap_reverse {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "horizontal-tb",
//        "width": 120,
//        "height": 120,
//        "wrap": "wrap-reverse",
//        "children": [
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 8.751998901367188,
//                "measure-height": 22,
//                "_y": 82
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 38,
//                "_y": 82
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 76,
//                "_y": 82
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_y": 42
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 38,
//                "_y": 42
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 76,
//                "_y": 42
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 6.415985107421875,
//                "measure-height": 22,
//                "_y": 2
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 38,
//                "_y": 2
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 76,
//                "_y": 2
//            }
//        ]
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox-flex-wrap-wrap.htm
- (void)test_flexbox_flex_wrap_wrap {
    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "horizontal-tb",
//        "width": 120,
//        "height": 120,
//        "wrap": "wrap",
//        "children": [
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 6.415985107421875,
//                "measure-height": 22
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 38
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 76
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_y": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 38,
//                "_y": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 76,
//                "_y": 40
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 8.751998901367188,
//                "measure-height": 22,
//                "_y": 80
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 38,
//                "_y": 80
//            },
//            {
//                "width": 38,
//                "height": 38,
//                "measure-width": 9.599990844726562,
//                "measure-height": 22,
//                "_x": 76,
//                "_y": 80
//            }
//        ]
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox-order-only-flexitems.html
- (void)test_flexbox_order_only_flexitems {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_absolute-atomic.html
- (void)test_flexbox_absolute_atomic {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "justify-content": "space-around",
        "children": [
            {
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 227,
                "_y": 20,
                "_width": 46,
                "_height": 22
            },
            {
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 727,
                "_y": 20,
                "_width": 46,
                "_height": 22
            }
        ],
        "_width": 1000,
        "_height": 62
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-content-center.html
- (void)test_flexbox_align_content_center {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-content": "center",
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 16
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 48
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-content-flexend.html
- (void)test_flexbox_align_content_flexend {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-content": "end",
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 32
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 32
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 64
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-content-flexstart.html
- (void)test_flexbox_align_content_flexstart {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-content": "start",
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 32
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-content-spacearound.html
- (void)test_flexbox_align_content_spacearound {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-content": "space-around",
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 8
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 8
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 56
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-content-spacebetween.html
- (void)test_flexbox_align_content_spacebetween {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-content": "space-between",
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 64
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-content-stretch-2.html
- (void)test_flexbox_align_content_stretch_2 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-content": "stretch",
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_height": 48
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_height": 48
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 48,
                "_height": 48
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-content-stretch.html
- (void)test_flexbox_align_content_stretch {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-content": "stretch",
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 48
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-items-baseline.html
- (void)test_flexbox_align_items_baseline {
    // TODO 'baseline' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "width": 480,
//        "height": 96,
//        "margin-top": 16,
//        "margin-bottom": 16,
//        "align-items": "baseline",
//        "children": [
//            {
//                "width": 128,
//                "height": 32,
//                "flex-basis": "auto",
//                "margin-right": 16,
//                "margin-left": 16,
//                "flex-grow": 0,
//                "flex-shrink": 0,
//                "measure-width": 27.199981689453125,
//                "measure-height": 22,
//                "_x": 16,
//                "_y": 16
//            },
//            {
//                "width": 128,
//                "height": 48,
//                "flex-basis": "auto",
//                "margin-top": 16,
//                "margin-right": 16,
//                "margin-left": 16,
//                "flex-grow": 0,
//                "flex-shrink": 0,
//                "measure-width": 27.135971069335938,
//                "measure-height": 22,
//                "_x": 176,
//                "_y": 16
//            },
//            {
//                "width": 128,
//                "height": 64,
//                "flex-basis": "auto",
//                "margin-right": 16,
//                "margin-left": 16,
//                "flex-grow": 0,
//                "flex-shrink": 0,
//                "measure-width": 38.17596435546875,
//                "measure-height": 22,
//                "_x": 336,
//                "_y": 16
//            }
//        ],
//        "_y": 16
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-items-center-2.html
- (void)test_flexbox_align_items_center_2 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "center",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 32
            },
            {
                "width": 128,
                "height": 48,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 24
            },
            {
                "width": 128,
                "height": 64,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 336,
                "_y": 16
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-items-center.html
- (void)test_flexbox_align_items_center {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "center",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 32
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 32
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 336,
                "_y": 32
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-items-flexend-2.html
- (void)test_flexbox_align_items_flexend_2 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "end",
        "children": [
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 74,
                "_height": 22
            },
            {
                "width": 128,
                "height": 48,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 48
            },
            {
                "width": 128,
                "height": 64,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 336,
                "_y": 32
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-items-flexend.html
- (void)test_flexbox_align_items_flexend {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "end",
        "children": [
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 74,
                "_height": 22
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 74,
                "_height": 22
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 336,
                "_y": 74,
                "_height": 22
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-items-flexstart-2.html
- (void)test_flexbox_align_items_flexstart_2 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "start",
        "children": [
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_height": 22
            },
            {
                "width": 128,
                "height": 48,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176
            },
            {
                "width": 128,
                "height": 64,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 336
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-items-flexstart.html
- (void)test_flexbox_align_items_flexstart {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "start",
        "children": [
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_height": 22
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_height": 22
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 336,
                "_height": 22
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-items-stretch-2.html
- (void)test_flexbox_align_items_stretch_2 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "stretch",
        "children": [
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-top": 96,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 41.00798034667969,
                "measure-height": 22,
                "_y": 96,
                "_height": 0
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "_x": 128,
                "_height": 96
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 8.143997192382812,
                "measure-height": 22,
                "_x": 256,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-items-stretch.html
- (void)test_flexbox_align_items_stretch {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "stretch",
        "children": [
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_height": 96
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-top": 48,
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 48,
                "_height": 48
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 336,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-self-auto.html
- (void)test_flexbox_align_self_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "end",
        "children": [
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 74,
                "_height": 22
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 74,
                "_height": 22
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "align-self": "auto",
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 336,
                "_y": 74,
                "_height": 22
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-self-baseline.html
- (void)test_flexbox_align_self_baseline {
    // TODO 'baseline' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "width": 480,
//        "height": 96,
//        "margin-top": 16,
//        "margin-bottom": 16,
//        "align-items": "center",
//        "children": [
//            {
//                "width": 128,
//                "height": 48,
//                "flex-basis": "auto",
//                "margin-right": 16,
//                "margin-left": 16,
//                "flex-grow": 0,
//                "flex-shrink": 0,
//                "measure-width": 27.199981689453125,
//                "measure-height": 22,
//                "_x": 16,
//                "_y": 24
//            },
//            {
//                "width": 128,
//                "height": 48,
//                "flex-basis": "auto",
//                "margin-right": 16,
//                "margin-left": 16,
//                "flex-grow": 0,
//                "flex-shrink": 0,
//                "measure-width": 27.135971069335938,
//                "measure-height": 22,
//                "_x": 176,
//                "_y": 24
//            },
//            {
//                "width": 128,
//                "height": 48,
//                "flex-basis": "auto",
//                "margin-right": 16,
//                "margin-left": 16,
//                "flex-grow": 0,
//                "flex-shrink": 0,
//                "align-self": "baseline",
//                "measure-width": 38.17596435546875,
//                "measure-height": 22,
//                "_x": 336
//            }
//        ],
//        "_y": 16
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-self-center.html
- (void)test_flexbox_align_self_center {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "start",
        "children": [
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_height": 22
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_height": 22
            },
            {
                "width": 128,
                "height": 64,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "align-self": "center",
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 336,
                "_y": 16
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-self-flexend.html
- (void)test_flexbox_align_self_flexend {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "start",
        "children": [
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_height": 22
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_height": 22
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "align-self": "end",
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 336,
                "_y": 74,
                "_height": 22
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-self-flexstart.html
- (void)test_flexbox_align_self_flexstart {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "end",
        "children": [
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 74,
                "_height": 22
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 74,
                "_height": 22
            },
            {
                "width": 128,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "align-self": "start",
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 336,
                "_height": 22
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_align-self-stretch.html
- (void)test_flexbox_align_self_stretch {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 96,
        "margin-top": 16,
        "margin-bottom": 16,
        "align-items": "center",
        "children": [
            {
                "width": 128,
                "height": 48,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 24
            },
            {
                "width": 128,
                "height": 48,
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 24
            },
            {
                "width": 128,
                "height": "auto",
                "flex-basis": "auto",
                "margin-right": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "align-self": "stretch",
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 336,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_box-clear.html
- (void)test_flexbox_box_clear {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "children": [
            {
                "height": 64,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 304.1436767578125,
                "measure-height": 22,
                "_x": 32,
                "_y": 32,
                "_width": 304
            }
        ],
        "_width": 1000,
        "_height": 128
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_columns.html
- (void)test_flexbox_columns {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "justify-content": "space-around",
        "children": [
            {
                "measure-width": 138.6398468017578,
                "measure-height": 22,
                "_x": 67,
                "_width": 139,
                "_height": 22
            },
            {
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 341,
                "_width": 47,
                "_height": 22
            },
            {
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 523,
                "_width": 46,
                "_height": 22
            },
            {
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 704,
                "_width": 47,
                "_height": 22
            },
            {
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 886,
                "_width": 47,
                "_height": 22
            }
        ],
        "_width": 1000,
        "_height": 22
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_direction-column-reverse.html
- (void)test_flexbox_direction_column_reverse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 16,
        "margin-bottom": 16,
        "direction": "vertical-reverse",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 178,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 124,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 22
            }
        ],
        "_y": 16,
        "_width": 1000,
        "_height": 216
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_direction-column.html
- (void)test_flexbox_direction_column {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 16,
        "margin-bottom": 16,
        "direction": "vertical",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 124,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 178,
                "_height": 22
            }
        ],
        "_y": 16,
        "_width": 1000,
        "_height": 216
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_direction-row-reverse.html
- (void)test_flexbox_direction_row_reverse {
    XCTAssertLayoutWithConfig(130, FlexAuto, 1, @R"(
    {
        "direction": "horizontal-reverse",
        "children": [
            {
                "width": 130,
                "measure-width": 31.205078125,
                "measure-height": 15,
                "_x": 87,
                "_width": 43,
                "_height": 15
            },
            {
                "width": 130,
                "measure-width": 31.205078125,
                "measure-height": 15,
                "_x": 43,
                "_width": 44,
                "_height": 15
            },
            {
                "width": 130,
                "measure-width": 31.205078125,
                "measure-height": 15,
                "_width": 43,
                "_height": 15
            }
        ],
        "_width": 130,
        "_height": 15
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_display.html
- (void)test_flexbox_display {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_fbfc.html
- (void)test_flexbox_fbfc {
    XCTAssertLayoutWithConfig(600, FlexAuto, 1, @R"(
    {
        "width": "80%",
        "children": [
            {
                "height": 64,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 304.1436767578125,
                "measure-height": 22,
                "_x": 32,
                "_y": 32,
                "_width": 304
            }
        ],
        "_width": 480,
        "_height": 128
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_fbfc2.html
- (void)test_flexbox_fbfc2 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 400,
        "margin-left": -200,
        "children": [
            {
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 247.35972595214844,
                "measure-height": 22,
                "_x": 32,
                "_y": 32,
                "_width": 247,
                "_height": 22
            }
        ],
        "_x": -200,
        "_height": 86
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_first-line.html
- (void)test_flexbox_first_line {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 900,
        "wrap": "wrap",
        "children": [
            {
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 32,
                "_y": 32,
                "_width": 47,
                "_height": 22
            },
            {
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 216.38381958007812,
                "measure-height": 22,
                "_x": 143,
                "_y": 32,
                "_width": 216,
                "_height": 22
            },
            {
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 423,
                "_y": 32,
                "_width": 47,
                "_height": 22
            },
            {
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 216.38381958007812,
                "measure-height": 22,
                "_x": 534,
                "_y": 32,
                "_width": 216,
                "_height": 22
            },
            {
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 216.38381958007812,
                "measure-height": 22,
                "_x": 32,
                "_y": 118,
                "_width": 216,
                "_height": 22
            },
            {
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 312,
                "_y": 118,
                "_width": 47,
                "_height": 22
            },
            {
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 216.38381958007812,
                "measure-height": 22,
                "_x": 423,
                "_y": 118,
                "_width": 217,
                "_height": 22
            },
            {
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 704,
                "_y": 118,
                "_width": 46,
                "_height": 22
            }
        ],
        "_height": 172
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-0-0-unitless.html
- (void)test_flexbox_flex_0_0_0_unitless {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-0-0.html
- (void)test_flexbox_flex_0_0_0 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-0-1-unitless-basis.html
- (void)test_flexbox_flex_0_0_1_unitless_basis {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 80,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-0-N-shrink.html
- (void)test_flexbox_flex_0_0_N_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 64,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-0-N-unitless-basis.html
- (void)test_flexbox_flex_0_0_N_unitless_basis {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 80,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-0-N.html
- (void)test_flexbox_flex_0_0_N {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 64,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-0-Npercent-shrink.html
- (void)test_flexbox_flex_0_0_Npercent_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 288,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-0-Npercent.html
- (void)test_flexbox_flex_0_0_Npercent {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 128,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 128,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 256,
                "_y": 16,
                "_width": 128,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 384,
                "_y": 16,
                "_width": 128,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-0-auto-shrink.html
- (void)test_flexbox_flex_0_0_auto_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 256,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 80,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-0-auto.html
- (void)test_flexbox_flex_0_0_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 80,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-0.html
- (void)test_flexbox_flex_0_0 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-1-0-unitless.html
- (void)test_flexbox_flex_0_1_0_unitless {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-1-0.html
- (void)test_flexbox_flex_0_1_0 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-1-1-unitless-basis.html
- (void)test_flexbox_flex_0_1_1_unitless_basis {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 80,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-1-N-shrink.html
- (void)test_flexbox_flex_0_1_N_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 48,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 48,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-1-N-unitless-basis.html
- (void)test_flexbox_flex_0_1_N_unitless_basis {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 80,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-1-N.html
- (void)test_flexbox_flex_0_1_N {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 64,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-1-Npercent-shrink.html
- (void)test_flexbox_flex_0_1_Npercent_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 48,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 48,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-1-Npercent.html
- (void)test_flexbox_flex_0_1_Npercent {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 128,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 128,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 256,
                "_y": 16,
                "_width": 128,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 384,
                "_y": 16,
                "_width": 128,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-1-auto-shrink.html
- (void)test_flexbox_flex_0_1_auto_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 256,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 64,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-1-auto.html
- (void)test_flexbox_flex_0_1_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 80,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-1.html
- (void)test_flexbox_flex_0_1 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-N-0-unitless.html
- (void)test_flexbox_flex_0_N_0_unitless {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-N-0.html
- (void)test_flexbox_flex_0_N_0 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-N-N-shrink.html
- (void)test_flexbox_flex_0_N_N_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 48,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 48,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-N-N.html
- (void)test_flexbox_flex_0_N_N {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 64,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-N-Npercent-shrink.html
- (void)test_flexbox_flex_0_N_Npercent_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 48,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 48,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-N-Npercent.html
- (void)test_flexbox_flex_0_N_Npercent {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 128,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 128,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 256,
                "_y": 16,
                "_width": 128,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 384,
                "_y": 16,
                "_width": 128,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-N-auto-shrink.html
- (void)test_flexbox_flex_0_N_auto_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 256,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 64,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-N-auto.html
- (void)test_flexbox_flex_0_N_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 80,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-N.html
- (void)test_flexbox_flex_0_N {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 0,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_y": 16,
                "_width": 0,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-0-auto.html
- (void)test_flexbox_flex_0_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 352,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_width": 56,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 104,
                "_y": 16,
                "_width": 56,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 56,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 280,
                "_y": 16,
                "_width": 56,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 352,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_width": 56,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 104,
                "_y": 16,
                "_width": 56,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 56,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 280,
                "_y": 16,
                "_width": 56,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-0-0-unitless.html
- (void)test_flexbox_flex_1_0_0_unitless {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-0-0.html
- (void)test_flexbox_flex_1_0_0 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-0-N-shrink.html
- (void)test_flexbox_flex_1_0_N_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 64,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-0-N.html
- (void)test_flexbox_flex_1_0_N {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-0-Npercent-shrink.html
- (void)test_flexbox_flex_1_0_Npercent_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 288,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-0-Npercent.html
- (void)test_flexbox_flex_1_0_Npercent {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-0-auto-shrink.html
- (void)test_flexbox_flex_1_0_auto_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 256,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 80,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-0-auto.html
- (void)test_flexbox_flex_1_0_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-0.html
- (void)test_flexbox_flex_1_0 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-1-0-unitless.html
- (void)test_flexbox_flex_1_1_0_unitless {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-1-0.html
- (void)test_flexbox_flex_1_1_0 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-1-N-shrink.html
- (void)test_flexbox_flex_1_1_N_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 48,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 48,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-1-N.html
- (void)test_flexbox_flex_1_1_N {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-1-Npercent-shrink.html
- (void)test_flexbox_flex_1_1_Npercent_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 48,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 48,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-1-Npercent.html
- (void)test_flexbox_flex_1_1_Npercent {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-1-auto-shrink.html
- (void)test_flexbox_flex_1_1_auto_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 256,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 64,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-1-auto.html
- (void)test_flexbox_flex_1_1_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-1.html
- (void)test_flexbox_flex_1_1 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-N-0-unitless.html
- (void)test_flexbox_flex_1_N_0_unitless {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-N-0.html
- (void)test_flexbox_flex_1_N_0 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-N-N-shrink.html
- (void)test_flexbox_flex_1_N_N_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 48,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 48,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-N-N.html
- (void)test_flexbox_flex_1_N_N {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-N-Npercent-shrink.html
- (void)test_flexbox_flex_1_N_Npercent_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 48,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 48,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-N-Npercent.html
- (void)test_flexbox_flex_1_N_Npercent {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-N-auto-shrink.html
- (void)test_flexbox_flex_1_N_auto_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 256,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 64,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-N-auto.html
- (void)test_flexbox_flex_1_N_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-1-N.html
- (void)test_flexbox_flex_1_N {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-0-0-unitless.html
- (void)test_flexbox_flex_N_0_0_unitless {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-0-0.html
- (void)test_flexbox_flex_N_0_0 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-0-N-shrink.html
- (void)test_flexbox_flex_N_0_N_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 64,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-0-N.html
- (void)test_flexbox_flex_N_0_N {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-0-Npercent-shrink.html
- (void)test_flexbox_flex_N_0_Npercent_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 288,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-0-Npercent.html
- (void)test_flexbox_flex_N_0_Npercent {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-0-auto-shrink.html
- (void)test_flexbox_flex_N_0_auto_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 80,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-0-auto.html
- (void)test_flexbox_flex_N_0_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-0.html
- (void)test_flexbox_flex_N_0 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-1-0-unitless.html
- (void)test_flexbox_flex_N_1_0_unitless {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-1-0.html
- (void)test_flexbox_flex_N_1_0 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-1-N-shrink.html
- (void)test_flexbox_flex_N_1_N_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 48,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 48,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-1-N.html
- (void)test_flexbox_flex_N_1_N {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-1-Npercent-shrink.html
- (void)test_flexbox_flex_N_1_Npercent_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 48,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 48,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-1-Npercent.html
- (void)test_flexbox_flex_N_1_Npercent {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-1-auto-shrink.html
- (void)test_flexbox_flex_N_1_auto_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 256,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 64,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-1-auto.html
- (void)test_flexbox_flex_N_1_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-1.html
- (void)test_flexbox_flex_N_1 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-N-0-unitless.html
- (void)test_flexbox_flex_N_N_0_unitless {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 0,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-N-0.html
- (void)test_flexbox_flex_N_N_0 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-N-N-shrink.html
- (void)test_flexbox_flex_N_N_N_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 48,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 48,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-N-N.html
- (void)test_flexbox_flex_N_N_N {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": 64,
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-N-Npercent-shrink.html
- (void)test_flexbox_flex_N_N_Npercent_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 192,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 48,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 48,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 48,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-N-Npercent.html
- (void)test_flexbox_flex_N_N_Npercent {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "20%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-N-auto-shrink.html
- (void)test_flexbox_flex_N_N_auto_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 256,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 64,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 64,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-N-auto.html
- (void)test_flexbox_flex_N_N_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-N-N.html
- (void)test_flexbox_flex_N_N {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 160,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 160,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 4,
                "flex-shrink": 2,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_width": 160,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-auto.html
- (void)test_flexbox_flex_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 512,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 272,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 400,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 512,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 144,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 272,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 400,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-basis-shrink.html
- (void)test_flexbox_flex_basis_shrink {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 384,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "50%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 288,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-basis.html
- (void)test_flexbox_flex_basis {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 128,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "100%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 128,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "100%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_width": 128,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "100%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 256,
                "_y": 16,
                "_width": 128,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "100%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 384,
                "_y": 16,
                "_width": 128,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-formatting-interop.html
- (void)test_flexbox_flex_formatting_interop {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "margin-left": -200,
        "children": [
            {
                "flex-basis": "auto",
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 322.0318603515625,
                "measure-height": 22,
                "_x": 32,
                "_width": 322,
                "_height": 22
            }
        ],
        "_x": -200,
        "_height": 54
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-initial-2.html
- (void)test_flexbox_flex_initial_2 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "initial",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": null,
                "flex-shrink": null,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "initial",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": null,
                "flex-shrink": null,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "initial",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": null,
                "flex-shrink": null,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "initial",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": null,
                "flex-shrink": null,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 352,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 640,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 352,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-initial.html
- (void)test_flexbox_flex_initial {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 352,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "initial",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": null,
                "flex-shrink": null,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_width": 56,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "initial",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": null,
                "flex-shrink": null,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 104,
                "_y": 16,
                "_width": 56,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "initial",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": null,
                "flex-shrink": null,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 56,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "initial",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": null,
                "flex-shrink": null,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 280,
                "_y": 16,
                "_width": 56,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 352,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_width": 56,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 104,
                "_y": 16,
                "_width": 56,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 56,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 280,
                "_y": 16,
                "_width": 56,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-natural-mixed-basis-auto.html
- (void)test_flexbox_flex_natural_mixed_basis_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 560,
        "height": 128,
        "children": [
            {
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 8.944000244140625,
                "measure-height": 22,
                "_width": 89,
                "_height": 128
            },
            {
                "flex-basis": "auto",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 26.832000732421875,
                "measure-height": 22,
                "_x": 89,
                "_width": 115,
                "_height": 128
            },
            {
                "flex-basis": "auto",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 44.720001220703125,
                "measure-height": 22,
                "_x": 204,
                "_width": 133,
                "_height": 128
            },
            {
                "flex-basis": "auto",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 134.16000366210938,
                "measure-height": 22,
                "_x": 337,
                "_width": 223,
                "_height": 128
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-natural-mixed-basis.html
- (void)test_flexbox_flex_natural_mixed_basis {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 560,
        "height": 128,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_height": 128
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 80,
                "_width": 160,
                "_height": 128
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 240,
                "_width": 160,
                "_height": 128
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 400,
                "_width": 160,
                "_height": 128
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-natural-variable-auto-basis.html
- (void)test_flexbox_flex_natural_variable_auto_basis {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 512,
        "height": 128,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_width": 112,
                "_height": 128
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "flex-grow": 3,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 112,
                "_width": 176,
                "_height": 128
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 288,
                "_width": 112,
                "_height": 128
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 400,
                "_width": 112,
                "_height": 128
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-natural-variable-zero-basis.html
- (void)test_flexbox_flex_natural_variable_zero_basis {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 576,
        "height": 128,
        "children": [
            {
                "width": 96,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_height": 128
            },
            {
                "width": 96,
                "flex-basis": "0%",
                "flex-grow": 3,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 96,
                "_width": 288,
                "_height": 128
            },
            {
                "width": 96,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 384,
                "_height": 128
            },
            {
                "width": 96,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 480,
                "_height": 128
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-natural.html
- (void)test_flexbox_flex_natural {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 800,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 2,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 200,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 2,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 200,
                "_y": 16,
                "_width": 200,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 2,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 400,
                "_y": 16,
                "_width": 200,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 2,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 600,
                "_y": 16,
                "_width": 200,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 800,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 666,
                "flex-shrink": 1,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_width": 200,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 666,
                "flex-shrink": 1,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 200,
                "_y": 16,
                "_width": 200,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 666,
                "flex-shrink": 1,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 400,
                "_y": 16,
                "_width": 200,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-bottom": 16,
                "flex-grow": 666,
                "flex-shrink": 1,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 600,
                "_y": 16,
                "_width": 200,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flex-none.html
- (void)test_flexbox_flex_none {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 512,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 352,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 512,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 128,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 352,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flow-column-reverse-wrap-reverse.html
- (void)test_flexbox_flow_column_reverse_wrap_reverse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "wrap": "wrap-reverse",
        "direction": "vertical-reverse",
        "children": [
            {
                "width": 128,
                "height": 24,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 176,
                "_y": 88
            },
            {
                "width": 128,
                "height": 24,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 32
            },
            {
                "width": 128,
                "height": 24,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 88
            },
            {
                "width": 128,
                "height": 24,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 16,
                "_y": 32
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flow-column-reverse-wrap.html
- (void)test_flexbox_flow_column_reverse_wrap {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "wrap": "wrap",
        "direction": "vertical-reverse",
        "children": [
            {
                "width": 128,
                "height": 24,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 88
            },
            {
                "width": 128,
                "height": 24,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 16,
                "_y": 32
            },
            {
                "width": 128,
                "height": 24,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 176,
                "_y": 88
            },
            {
                "width": 128,
                "height": 24,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 176,
                "_y": 32
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flow-column-wrap-reverse.html
- (void)test_flexbox_flow_column_wrap_reverse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "wrap": "wrap-reverse",
        "direction": "vertical",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 176,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 16,
                "_y": 70,
                "_height": 22
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flow-column-wrap.html
- (void)test_flexbox_flow_column_wrap {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 16,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 176,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 176,
                "_y": 70,
                "_height": 22
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flow-row-wrap-reverse.html
- (void)test_flexbox_flow_row_wrap_reverse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "margin-top": 16,
        "margin-bottom": 16,
        "wrap": "wrap-reverse",
        "direction": "horizontal",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 176,
                "_y": 16,
                "_height": 22
            }
        ],
        "_y": 16,
        "_height": 108
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_flow-row-wrap.html
- (void)test_flexbox_flow_row_wrap {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "margin-top": 16,
        "margin-bottom": 16,
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 176,
                "_y": 70,
                "_height": 22
            }
        ],
        "_y": 16,
        "_height": 108
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_item-bottom-float.html
- (void)test_flexbox_item_bottom_float {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 400,
        "height": 96,
        "margin-top": 16,
        "margin-right": 16,
        "margin-bottom": 16,
        "margin-left": 16,
        "children": [
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 32,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 128,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 224,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 320,
                "_y": 32
            }
        ],
        "_x": 16,
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_item-float.html
- (void)test_flexbox_item_float {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 16,
        "margin-right": 16,
        "margin-bottom": 16,
        "margin-left": 16,
        "children": [
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 32,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 128,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 224,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 320,
                "_y": 32
            }
        ],
        "_x": 16,
        "_y": 16,
        "_width": 968,
        "_height": 96
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_item-top-float.html
- (void)test_flexbox_item_top_float {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 400,
        "margin-top": 16,
        "margin-right": 16,
        "margin-bottom": 16,
        "margin-left": 16,
        "children": [
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 32,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 128,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 224,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 320,
                "_y": 32
            }
        ],
        "_x": 16,
        "_y": 16,
        "_height": 96
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_item-vertical-align.html
- (void)test_flexbox_item_vertical_align {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 600,
        "children": [
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 32,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 128,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 224,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 320,
                "_y": 32
            },
            {
                "width": 32,
                "height": 32,
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "_x": 416,
                "_y": 32
            }
        ],
        "_height": 96
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_justifycontent-center-overflow.html
- (void)test_flexbox_justifycontent_center_overflow {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 52,
        "height": 104,
        "margin-top": 13,
        "margin-left": 130,
        "justify-content": "center",
        "children": [
            {
                "width": 65,
                "max-width": 78,
                "flex-basis": "0%",
                "margin-top": 13,
                "margin-right": 13,
                "margin-bottom": 13,
                "margin-left": 13,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 23.40380859375,
                "measure-height": 15,
                "_y": 13,
                "_width": 0,
                "_height": 78
            },
            {
                "width": 65,
                "max-width": 78,
                "flex-basis": "0%",
                "margin-top": 13,
                "margin-right": 13,
                "margin-bottom": 13,
                "margin-left": 13,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 23.40380859375,
                "measure-height": 15,
                "_x": 26,
                "_y": 13,
                "_width": 0,
                "_height": 78
            },
            {
                "width": 65,
                "max-width": 78,
                "flex-basis": "0%",
                "margin-top": 13,
                "margin-right": 13,
                "margin-bottom": 13,
                "margin-left": 13,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 23.40380859375,
                "measure-height": 15,
                "_x": 52,
                "_y": 13,
                "_width": 0,
                "_height": 78
            }
        ],
        "_x": 130,
        "_y": 13
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_justifycontent-center.html
- (void)test_flexbox_justifycontent_center {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "justify-content": "center",
        "children": [
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 64,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 320,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_justifycontent-flex-end.html
- (void)test_flexbox_justifycontent_flex_end {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "justify-content": "end",
        "children": [
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 112,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 240,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 368,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_justifycontent-flex-start.html
- (void)test_flexbox_justifycontent_flex_start {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "justify-content": "start",
        "children": [
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": "auto",
                "margin-bottom": 16,
                "margin-left": "auto",
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 32,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": "auto",
                "margin-bottom": 16,
                "margin-left": "auto",
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": "auto",
                "margin-bottom": 16,
                "margin-left": "auto",
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 352,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_justifycontent-spacearound-negative.html
- (void)test_flexbox_justifycontent_spacearound_negative {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 272,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "justify-content": "space-around",
        "children": [
            {
                "width": 64,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 8,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 64,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 104,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 64,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 200,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_justifycontent-spacearound-only.html
- (void)test_flexbox_justifycontent_spacearound_only {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "justify-content": "space-around",
        "children": [
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_justifycontent-spacearound.html
- (void)test_flexbox_justifycontent_spacearound {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "justify-content": "space-around",
        "children": [
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 32,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 352,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_justifycontent-spacebetween-negative.html
- (void)test_flexbox_justifycontent_spacebetween_negative {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 272,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "justify-content": "space-between",
        "children": [
            {
                "width": 64,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 64,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 112,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 64,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 208,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_justifycontent-spacebetween-only.html
- (void)test_flexbox_justifycontent_spacebetween_only {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "justify-content": "space-between",
        "children": [
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_justifycontent-spacebetween.html
- (void)test_flexbox_justifycontent_spacebetween {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 480,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "justify-content": "space-between",
        "children": [
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_width": 96,
                "_height": 96
            },
            {
                "width": 80,
                "max-width": 96,
                "flex-basis": "0%",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 1,
                "flex-shrink": 0,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 368,
                "_y": 16,
                "_width": 96,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_margin-auto-overflow-2.html
- (void)test_flexbox_margin_auto_overflow_2 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 512,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 192,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": "auto",
                "margin-bottom": 16,
                "margin-left": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 480,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": "auto",
                "margin-bottom": 16,
                "margin-left": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 192,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_margin-auto-overflow.html
- (void)test_flexbox_margin_auto_overflow {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 512,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 480,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": "auto",
                "margin-bottom": 16,
                "margin-left": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 480,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": "auto",
                "margin-bottom": 16,
                "margin-left": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 480,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_margin-auto.html
- (void)test_flexbox_margin_auto {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 512,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "width": 64,
                "margin-top": 16,
                "margin-right": "auto",
                "margin-bottom": 16,
                "margin-left": "auto",
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 96,
                "_y": 16,
                "_height": 96
            },
            {
                "width": 64,
                "margin-top": 16,
                "margin-right": "auto",
                "margin-bottom": 16,
                "margin-left": "auto",
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 352,
                "_y": 16,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_margin-collapse.html
- (void)test_flexbox_margin_collapse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "direction": "vertical",
        "children": [
            {
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_y": 16,
                "_width": 1000,
                "_height": 22
            },
            {
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_y": 70,
                "_width": 1000,
                "_height": 22
            }
        ],
        "_width": 1000,
        "_height": 108
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_margin-left-ex.html
- (void)test_flexbox_margin_left_ex {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 512,
        "height": 128,
        "margin-top": 16,
        "margin-bottom": 16,
        "children": [
            {
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_width": 27,
                "_height": 96
            },
            {
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 75,
                "_y": 16,
                "_width": 27,
                "_height": 96
            },
            {
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 134,
                "_y": 16,
                "_width": 39,
                "_height": 96
            },
            {
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": "auto",
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 466,
                "_y": 16,
                "_width": 30,
                "_height": 96
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_nested-flex.html
- (void)test_flexbox_nested_flex {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "children": [
            {
                "width": 200,
                "height": 32,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 24.431991577148438,
                "measure-height": 22,
                "_x": 16,
                "_y": 16
            }
        ],
        "_width": 1000,
        "_height": 64
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_object.html
- (void)test_flexbox_object {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "justify-content": "space-around",
        "children": [
            {
                "measure-width": 249.0717010498047,
                "measure-height": 22,
                "_x": 125,
                "_width": 250,
                "_height": 22
            },
            {
                "measure-width": 249.0717010498047,
                "measure-height": 22,
                "_x": 625,
                "_width": 250,
                "_height": 22
            }
        ],
        "_width": 1000,
        "_height": 22
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_order-abspos-space-around.html
- (void)test_flexbox_order_abspos_space_around {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 432,
        "height": 128,
        "justify-content": "space-around",
        "children": [
            {
                "width": 80,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 32,
                "_height": 128
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 176,
                "_height": 128
            },
            {
                "width": 80,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 320,
                "_height": 128
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_order-noninteger-invalid.html
- (void)test_flexbox_order_noninteger_invalid {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "height": 64,
        "children": [
            {
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 100,
                "_height": 64
            },
            {
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 100,
                "_width": 100,
                "_height": 64
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_rowspan-overflow-automatic.html
- (void)test_flexbox_rowspan_overflow_automatic {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_rowspan-overflow.html
- (void)test_flexbox_rowspan_overflow {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_rowspan.html
- (void)test_flexbox_rowspan {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_stf-abspos.html
- (void)test_flexbox_stf_abspos {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_stf-fixpos.html
- (void)test_flexbox_stf_fixpos {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_stf-float.html
- (void)test_flexbox_stf_float {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_stf-inline-block.html
- (void)test_flexbox_stf_inline_block {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_stf-table-caption.html
- (void)test_flexbox_stf_table_caption {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_stf-table-cell.html
- (void)test_flexbox_stf_table_cell {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_stf-table-row-group.html
- (void)test_flexbox_stf_table_row_group {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_stf-table-row.html
- (void)test_flexbox_stf_table_row {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_stf-table-singleline-2.html
- (void)test_flexbox_stf_table_singleline_2 {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_stf-table-singleline.html
- (void)test_flexbox_stf_table_singleline {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_stf-table.html
- (void)test_flexbox_stf_table {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_table-fixed-layout.html
- (void)test_flexbox_table_fixed_layout {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_visibility-collapse-line-wrapping.html
- (void)test_flexbox_visibility_collapse_line_wrapping {
    XCTAssertLayoutWithConfig(602, FlexAuto, 1, @R"(
    {
        "wrap": "wrap",
        "children": [
            {
                "width": 300,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 300,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 300,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 300,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 32.9439697265625,
                "measure-height": 22,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 300,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 32.9439697265625,
                "measure-height": 22,
                "_x": 300,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 300,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_y": 124,
                "_height": 22
            },
            {
                "width": 300,
                "margin-top": 16,
                "margin-bottom": 16,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 300,
                "_y": 124,
                "_height": 22
            }
        ],
        "_width": 602,
        "_height": 162
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_visibility-collapse.html
- (void)test_flexbox_visibility_collapse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "children": [
            {
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 32,
                "_y": 32,
                "_width": 47,
                "_height": 22
            },
            {
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 32.9439697265625,
                "measure-height": 22,
                "_x": 143,
                "_y": 32,
                "_width": 33,
                "_height": 22
            },
            {
                "margin-top": 32,
                "margin-right": 32,
                "margin-bottom": 32,
                "margin-left": 32,
                "measure-width": 46.719970703125,
                "measure-height": 22,
                "_x": 240,
                "_y": 32,
                "_width": 46,
                "_height": 22
            }
        ],
        "_width": 1000,
        "_height": 86
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_wrap-long.html
- (void)test_flexbox_wrap_long {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "margin-top": 16,
        "margin-bottom": 16,
        "wrap": "wrap",
        "children": [
            {
                "width": 384,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_width": 288,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 16,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 176,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 16,
                "_y": 124,
                "_height": 22
            }
        ],
        "_y": 16,
        "_height": 162
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_wrap-reverse.html
- (void)test_flexbox_wrap_reverse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "margin-top": 16,
        "margin-bottom": 16,
        "wrap": "wrap-reverse",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 176,
                "_y": 16,
                "_height": 22
            }
        ],
        "_y": 16,
        "_height": 108
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_wrap.html
- (void)test_flexbox_wrap {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "margin-top": 16,
        "margin-bottom": 16,
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.199981689453125,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 27.135971069335938,
                "measure-height": 22,
                "_x": 176,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 38.17596435546875,
                "measure-height": 22,
                "_x": 16,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 30.143966674804688,
                "measure-height": 22,
                "_x": 176,
                "_y": 70,
                "_height": 22
            }
        ],
        "_y": 16,
        "_height": 108
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexbox_writing_mode_vertical_lays_out_contents_from_top_to_bottom.html
- (void)test_flexbox_writing_mode_vertical_lays_out_contents_from_top_to_bottom {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/flexible-box-float.html
- (void)test_flexible_box_float {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "align-content": "space-between",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 300,
                "height": 30
            },
            {
                "width": 300,
                "height": 30,
                "_x": 300
            }
        ],
        "_width": 1000,
        "_height": 30
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/justify-content-001.htm
- (void)test_justify_content_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "justify-content": "center",
        "children": [
            {
                "width": 76,
                "_x": 74,
                "_height": 100
            },
            {
                "width": 76,
                "_x": 150,
                "_height": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/justify-content-002.htm
- (void)test_justify_content_002 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "justify-content": "start",
        "children": [
            {
                "width": 75,
                "_height": 100
            },
            {
                "width": 75,
                "_x": 75,
                "_height": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/justify-content-003.htm
- (void)test_justify_content_003 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "justify-content": "end",
        "children": [
            {
                "width": 75,
                "_x": 150,
                "_height": 100
            },
            {
                "width": 75,
                "_x": 225,
                "_height": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/justify-content-004.htm
- (void)test_justify_content_004 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "justify-content": "space-between",
        "children": [
            {
                "width": 76,
                "_height": 100
            },
            {
                "width": 76,
                "_x": 224,
                "_height": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/justify-content-005.htm
- (void)test_justify_content_005 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "justify-content": "space-around",
        "children": [
            {
                "width": 76,
                "_x": 37,
                "_height": 100
            },
            {
                "width": 76,
                "_x": 187,
                "_height": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/justify-content_center.html
- (void)test_justify_content_center {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "height": 200,
        "justify-content": "center",
        "children": [
            {
                "width": 30,
                "measure-width": 8.019989013671875,
                "measure-height": 28,
                "_x": 55,
                "_height": 200
            },
            {
                "width": 30,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 85,
                "_height": 200
            },
            {
                "width": 30,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 115,
                "_height": 200
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/justify-content_flex-end.html
- (void)test_justify_content_flex_end {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "height": 200,
        "justify-content": "end",
        "children": [
            {
                "width": 30,
                "measure-width": 8.019989013671875,
                "measure-height": 28,
                "_x": 110,
                "_height": 200
            },
            {
                "width": 30,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 140,
                "_height": 200
            },
            {
                "width": 30,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 170,
                "_height": 200
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/justify-content_flex-start.html
- (void)test_justify_content_flex_start {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "height": 200,
        "justify-content": "start",
        "children": [
            {
                "width": 30,
                "measure-width": 8.019989013671875,
                "measure-height": 28,
                "_height": 200
            },
            {
                "width": 30,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 30,
                "_height": 200
            },
            {
                "width": 30,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 60,
                "_height": 200
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/justify-content_space-around.html
- (void)test_justify_content_space_around {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "height": 200,
        "justify-content": "space-around",
        "children": [
            {
                "width": 30,
                "measure-width": 8.019989013671875,
                "measure-height": 28,
                "_x": 18,
                "_height": 200
            },
            {
                "width": 30,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 85,
                "_height": 200
            },
            {
                "width": 30,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 152,
                "_height": 200
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/justify-content_space-between.html
- (void)test_justify_content_space_between {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "height": 200,
        "justify-content": "space-between",
        "children": [
            {
                "width": 30,
                "measure-width": 8.019989013671875,
                "measure-height": 28,
                "_height": 200
            },
            {
                "width": 30,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 85,
                "_height": 200
            },
            {
                "width": 30,
                "measure-width": 12,
                "measure-height": 28,
                "_x": 170,
                "_height": 200
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/layout-algorithm_algo-cross-line-001.html
- (void)test_layout_algorithm_algo_cross_line_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "children": [
            {
                "height": 200,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "_width": 100
            },
            {
                "height": 200,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "_x": 100,
                "_width": 100
            }
        ],
        "_height": 200
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/layout-algorithm_algo-cross-line-002.html
- (void)test_layout_algorithm_algo_cross_line_002 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 200,
        "height": 200,
        "direction": "vertical",
        "children": [
            {
                "width": 200,
                "height": 100
            },
            {
                "width": 200,
                "height": 100,
                "_y": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/negative-margins-001.html
- (void)test_negative_margins_001 {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/percentage-heights-000.html
- (void)test_percentage_heights_000 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "width": "40%",
                "height": "40%",
                "_width": 40,
                "_height": 40
            },
            {
                "width": "40%",
                "height": "40%",
                "_y": 40,
                "_width": 40,
                "_height": 40
            },
            {
                "width": "40%",
                "height": "40%",
                "_x": 40,
                "_width": 40,
                "_height": 40
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "width": "40%",
                "height": "40%",
                "margin-bottom": "10%",
                "_width": 40,
                "_height": 40
            },
            {
                "width": "40%",
                "height": "40%",
                "margin-bottom": "20%",
                "_x": 40,
                "_width": 40,
                "_height": 40
            },
            {
                "width": "40%",
                "height": "40%",
                "_x": 40,
                "_y": 60,
                "_width": 40,
                "_height": 40
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 100,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "width": "40%",
                "height": "40%",
                "max-height": "20%",
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "_width": 40,
                "_height": 20
            },
            {
                "width": "40%",
                "height": "40%",
                "_y": 20,
                "_width": 40,
                "_height": 40
            },
            {
                "width": "40%",
                "height": "40%",
                "_y": 60,
                "_width": 40,
                "_height": 40
            }
        ]
    }
    )");

    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "width": 100,
//        "height": 100,
//        "align-content": "start",
//        "wrap": "wrap",
//        "direction": "vertical",
//        "children": [
//            {
//                "width": "40%",
//                "height": "40%",
//                "_x": 60,
//                "_width": 40,
//                "_height": 40
//            },
//            {
//                "width": "40%",
//                "height": "40%",
//                "_x": 20,
//                "_width": 40,
//                "_height": 40
//            },
//            {
//                "width": "40%",
//                "height": "40%",
//                "_x": 60,
//                "_y": 40,
//                "_width": 40,
//                "_height": 40
//            }
//        ]
//    }
//    )");

    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "width": 100,
//        "height": 100,
//        "align-content": "start",
//        "wrap": "wrap",
//        "direction": "vertical",
//        "children": [
//            {
//                "width": "40%",
//                "height": "40%",
//                "margin-bottom": "10%",
//                "_x": 60,
//                "_width": 40,
//                "_height": 40
//            },
//            {
//                "width": "40%",
//                "height": "40%",
//                "margin-bottom": "20%",
//                "_x": 20,
//                "_width": 40,
//                "_height": 40
//            },
//            {
//                "width": "40%",
//                "height": "40%",
//                "_x": 60,
//                "_y": 60,
//                "_width": 40,
//                "_height": 40
//            }
//        ]
//    }
//    )");

    // TODO 'writing-mode' not supported
//XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
//    {
//        "writing-mode": "vertical-rl",
//        "width": 100,
//        "height": 100,
//        "align-content": "start",
//        "wrap": "wrap",
//        "direction": "vertical",
//        "children": [
//            {
//                "width": "40%",
//                "height": "40%",
//                "max-width": "20%",
//                "flex-basis": "0%",
//                "flex-grow": 1,
//                "flex-shrink": 1,
//                "_x": 80,
//                "_width": 20,
//                "_height": 40
//            },
//            {
//                "width": "40%",
//                "height": "40%",
//                "_x": 40,
//                "_width": 40,
//                "_height": 40
//            },
//            {
//                "width": "40%",
//                "height": "40%",
//                "_width": 40,
//                "_height": 40
//            }
//        ]
//    }
//    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/percentage-heights-001.html
- (void)test_percentage_heights_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 50,
        "children": [
            {
                "children": [
                    {
                        "height": "50%",
                        "children": [
                            {
                                "width": 50,
                                "height": 50
                            }
                        ],
                        "_width": 50,
                        "_height": 25
                    }
                ],
                "_width": 50,
                "_height": 50
            }
        ],
        "_height": 50
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 50,
        "wrap": "wrap",
        "children": [
            {
                "children": [
                    {
                        "height": "50%",
                        "children": [
                            {
                                "width": 50,
                                "height": 50
                            }
                        ],
                        "_width": 50,
                        "_height": 25
                    }
                ],
                "_width": 50,
                "_height": 50
            }
        ],
        "_height": 50
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 50,
        "height": 50,
        "wrap": "wrap",
        "children": [
            {
                "align-self": "start",
                "children": [
                    {
                        "height": "50%",
                        "children": [
                            {
                                "width": 50,
                                "height": 50
                            }
                        ],
                        "_width": 50,
                        "_height": 50
                    }
                ],
                "_width": 50,
                "_height": 50
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 50,
        "height": 50,
        "children": [
            {
                "children": [
                    {
                        "height": "50%",
                        "children": [
                            {
                                "width": 50,
                                "height": 50
                            }
                        ],
                        "_width": 50,
                        "_height": 25
                    }
                ],
                "_width": 50,
                "_height": 50
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 50,
        "height": 50,
        "children": [
            {
                "width": 50,
                "children": [
                    {
                        "children": [
                            {
                                "height": "50%",
                                "children": [
                                    {
                                        "width": 50,
                                        "height": 50
                                    }
                                ],
                                "_width": 50,
                                "_height": 25
                            }
                        ],
                        "_width": 50,
                        "_height": 50
                    }
                ],
                "_height": 50
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 50,
        "height": 50,
        "children": [
            {
                "width": 50,
                "direction": "vertical",
                "children": [
                    {
                        "flex-basis": "0%",
                        "flex-grow": 1,
                        "flex-shrink": 1,
                        "children": [
                            {
                                "height": "50%",
                                "children": [
                                    {
                                        "width": 50,
                                        "height": 50
                                    }
                                ],
                                "_width": 50,
                                "_height": 25
                            }
                        ],
                        "_width": 50,
                        "_height": 50
                    }
                ],
                "_height": 50
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 50,
        "height": 50,
        "children": [
            {
                "children": [
                    {
                        "height": "50%",
                        "min-height": 30,
                        "children": [
                            {
                                "width": 50,
                                "height": 50
                            }
                        ],
                        "_width": 50,
                        "_height": 30
                    }
                ],
                "_width": 50,
                "_height": 50
            }
        ]
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 50,
        "children": [
            {
                "children": [
                    {
                        "max-height": "50%",
                        "children": [
                            {
                                "width": 50,
                                "height": 50
                            }
                        ],
                        "_width": 50,
                        "_height": 25
                    }
                ],
                "_width": 50,
                "_height": 50
            }
        ],
        "_height": 50
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 50,
        "height": "10%",
        "children": [
            {
                "children": [
                    {
                        "height": "50%",
                        "children": [
                            {
                                "width": 50,
                                "height": 50
                            }
                        ],
                        "_width": 50,
                        "_height": 40
                    }
                ],
                "_width": 50,
                "_height": 80
            }
        ],
        "_height": 80
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 100,
        "height": 50,
        "children": [
            {
                "width": 100,
                "children": [
                    {
                        "width": "50%",
                        "children": [
                            {
                                "width": 50,
                                "height": 50
                            }
                        ],
                        "_width": 50,
                        "_height": 50
                    }
                ],
                "_height": 50
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/percentage-heights-002.html
- (void)test_percentage_heights_002 {
    XCTAssertLayoutWithConfig(800, FlexAuto, 1, @R"(
    {
        "top": 0,
        "right": 0,
        "bottom": 0,
        "left": 0,
        "direction": "vertical",
        "children": [
            {
                "height": "20%",
                "measure-width": 571.5034790039062,
                "measure-height": 22,
                "_width": 800,
                "_height": 100
            },
            {
                "flex-basis": "100%",
                "measure-width": 562.7034301757812,
                "measure-height": 22,
                "_y": 100,
                "_width": 800,
                "_height": 500
            }
        ],
        "_width": 800,
        "_height": 600
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/percentage-widths-001.html
- (void)test_percentage_widths_001 {
    XCTAssertLayoutWithConfig(600, FlexAuto, 1, @R"(
    {
        "top": 0,
        "right": 0,
        "bottom": 0,
        "left": 0,
        "direction": "horizontal",
        "children": [
            {
                "width": "20%",
                "measure-width": 565.7274780273438,
                "measure-height": 22,
                "_width": 100,
                "_height": 800
            },
            {
                "flex-basis": "100%",
                "measure-width": 556.9274291992188,
                "measure-height": 22,
                "_x": 100,
                "_width": 500,
                "_height": 800
            }
        ],
        "_width": 600,
        "_height": 800
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/ttwf-reftest-flex-align-content-center.html
- (void)test_ttwf_reftest_flex_align_content_center {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 96,
        "margin-top": 16,
        "margin-right": 16,
        "margin-bottom": 16,
        "margin-left": 16,
        "align-content": "center",
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 29.327972412109375,
                "measure-height": 22,
                "_x": 16
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 53.407958984375,
                "measure-height": 22,
                "_x": 176
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 33.887969970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 64
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 35.75996398925781,
                "measure-height": 22,
                "_x": 176,
                "_y": 64
            }
        ],
        "_x": 16,
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/ttwf-reftest-flex-align-content-end.html
- (void)test_ttwf_reftest_flex_align_content_end {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 224,
        "margin-top": 16,
        "margin-right": 16,
        "margin-bottom": 16,
        "margin-left": 16,
        "align-content": "end",
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 29.327972412109375,
                "measure-height": 22,
                "_x": 16,
                "_y": 112
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 53.407958984375,
                "measure-height": 22,
                "_x": 176,
                "_y": 112
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 33.887969970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 176
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 35.75996398925781,
                "measure-height": 22,
                "_x": 176,
                "_y": 176
            }
        ],
        "_x": 16,
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/ttwf-reftest-flex-align-content-space-around.html
- (void)test_ttwf_reftest_flex_align_content_space_around {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 224,
        "margin-top": 16,
        "margin-right": 16,
        "margin-bottom": 16,
        "margin-left": 16,
        "align-content": "space-around",
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 29.327972412109375,
                "measure-height": 22,
                "_x": 16,
                "_y": 40
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 53.407958984375,
                "measure-height": 22,
                "_x": 176,
                "_y": 40
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 33.887969970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 152
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 35.75996398925781,
                "measure-height": 22,
                "_x": 176,
                "_y": 152
            }
        ],
        "_x": 16,
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/ttwf-reftest-flex-align-content-space-between.html
- (void)test_ttwf_reftest_flex_align_content_space_between {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 224,
        "margin-top": 16,
        "margin-right": 16,
        "margin-bottom": 16,
        "margin-left": 16,
        "align-content": "space-between",
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 29.327972412109375,
                "measure-height": 22,
                "_x": 16,
                "_y": 16
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 53.407958984375,
                "measure-height": 22,
                "_x": 176,
                "_y": 16
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 33.887969970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 176
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 35.75996398925781,
                "measure-height": 22,
                "_x": 176,
                "_y": 176
            }
        ],
        "_x": 16,
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/ttwf-reftest-flex-align-content-start.html
- (void)test_ttwf_reftest_flex_align_content_start {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 224,
        "margin-top": 16,
        "margin-right": 16,
        "margin-bottom": 16,
        "margin-left": 16,
        "align-content": "start",
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 29.327972412109375,
                "measure-height": 22,
                "_x": 16,
                "_y": 16
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 53.407958984375,
                "measure-height": 22,
                "_x": 176,
                "_y": 16
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 33.887969970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 80
            },
            {
                "width": 128,
                "height": 32,
                "flex-basis": "auto",
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "flex-grow": 0,
                "flex-shrink": 0,
                "measure-width": 35.75996398925781,
                "measure-height": 22,
                "_x": 176,
                "_y": 80
            }
        ],
        "_x": 16,
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/ttwf-reftest-flex-base.html
- (void)test_ttwf_reftest_flex_base {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 48,
        "height": 96,
        "margin-top": 16,
        "margin-right": 16,
        "margin-bottom": 16,
        "margin-left": 16,
        "children": [
            {
                "width": 48,
                "measure-width": 37.29595947265625,
                "measure-height": 22,
                "_height": 96
            }
        ],
        "_x": 16,
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/ttwf-reftest-flex-direction-column-reverse.html
- (void)test_ttwf_reftest_flex_direction_column_reverse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 16,
        "margin-bottom": 16,
        "direction": "vertical-reverse",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 29.327972412109375,
                "measure-height": 22,
                "_x": 16,
                "_y": 178,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 53.407958984375,
                "measure-height": 22,
                "_x": 16,
                "_y": 124,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 33.887969970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 35.75996398925781,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 22
            }
        ],
        "_y": 16,
        "_width": 1000,
        "_height": 216
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/ttwf-reftest-flex-direction-column.html
- (void)test_ttwf_reftest_flex_direction_column {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 16,
        "margin-bottom": 16,
        "direction": "vertical",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 29.327972412109375,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 53.407958984375,
                "measure-height": 22,
                "_x": 16,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 33.887969970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 124,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 35.75996398925781,
                "measure-height": 22,
                "_x": 16,
                "_y": 178,
                "_height": 22
            }
        ],
        "_y": 16,
        "_width": 1000,
        "_height": 216
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/ttwf-reftest-flex-direction-row-reverse.html
- (void)test_ttwf_reftest_flex_direction_row_reverse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "margin-top": 16,
        "margin-bottom": 16,
        "direction": "horizontal-reverse",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 29.327972412109375,
                "measure-height": 22,
                "_x": 856,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 53.407958984375,
                "measure-height": 22,
                "_x": 696,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 33.887969970703125,
                "measure-height": 22,
                "_x": 536,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 35.75996398925781,
                "measure-height": 22,
                "_x": 376,
                "_y": 16,
                "_height": 22
            }
        ],
        "_y": 16,
        "_width": 1000,
        "_height": 54
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/ttwf-reftest-flex-inline.html
- (void)test_ttwf_reftest_flex_inline {
    // TODO Can not find the test element
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/ttwf-reftest-flex-wrap-reverse.html
- (void)test_ttwf_reftest_flex_wrap_reverse {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 104,
        "margin-top": 16,
        "margin-bottom": 16,
        "wrap": "wrap-reverse",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 29.327972412109375,
                "measure-height": 22,
                "_x": 16,
                "_y": 66,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 53.407958984375,
                "measure-height": 22,
                "_x": 176,
                "_y": 66,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 33.887969970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 12,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 35.75996398925781,
                "measure-height": 22,
                "_x": 176,
                "_y": 12,
                "_height": 22
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/ttwf-reftest-flex-wrap.html
- (void)test_ttwf_reftest_flex_wrap {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 320,
        "height": 104,
        "margin-top": 16,
        "margin-bottom": 16,
        "wrap": "wrap",
        "children": [
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 29.327972412109375,
                "measure-height": 22,
                "_x": 16,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 53.407958984375,
                "measure-height": 22,
                "_x": 176,
                "_y": 16,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 33.887969970703125,
                "measure-height": 22,
                "_x": 16,
                "_y": 70,
                "_height": 22
            },
            {
                "width": 128,
                "margin-top": 16,
                "margin-right": 16,
                "margin-bottom": 16,
                "margin-left": 16,
                "measure-width": 35.75996398925781,
                "measure-height": 22,
                "_x": 176,
                "_y": 70,
                "_height": 22
            }
        ],
        "_y": 16
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/visibility-collapse-001.htm
- (void)test_visibility_collapse_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "wrap": "initial",
        "direction": "vertical",
        "children": [
            {
                "height": 50,
                "_width": 300
            },
            {
                "height": 50,
                "_y": 50,
                "_width": 300
            },
            {
                "height": 50,
                "_y": 100,
                "_width": 300
            }
        ],
        "_height": 150
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/visibility-collapse-002.htm
- (void)test_visibility_collapse_002 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "width": 300,
        "height": 100,
        "children": [
            {
                "width": 150,
                "_width": 100,
                "_height": 100
            },
            {
                "width": 150,
                "_x": 100,
                "_width": 100,
                "_height": 100
            },
            {
                "width": 150,
                "_x": 200,
                "_width": 100,
                "_height": 100
            }
        ]
    }
    )");
}

// https://github.com/w3c/web-platform-tests/blob/master/css/css-flexbox-1/whitespace-in-flexitem-001.html
- (void)test_whitespace_in_flexitem_001 {
    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "justify-content": "space-around",
        "children": [
            {
                "width": 30,
                "flex-basis": "auto",
                "flex-grow": 0,
                "flex-shrink": 0,
                "_x": 485,
                "_height": 0
            }
        ],
        "_width": 1000,
        "_height": 0
    }
    )");

    XCTAssertLayoutWithConfig(1000, FlexAuto, 1, @R"(
    {
        "children": [
            {
                "measure-width": 25.247970581054688,
                "measure-height": 22,
                "_width": 25,
                "_height": 22
            },
            {
                "measure-width": 24.767974853515625,
                "measure-height": 22,
                "_x": 25,
                "_width": 25,
                "_height": 22
            }
        ],
        "_width": 1000,
        "_height": 22
    }
    )");
}

@end
