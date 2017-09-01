//
//  Generated with Yoga tests.
//
//  References:
//    Yoga: https://facebook.github.io/yoga/
//    Yoga test fixtures: https://github.com/facebook/yoga/tree/master/gentest/fixtures
//

#import <XCTest/XCTest.h>

@interface YogaTests : XCTestCase
@end
@implementation YogaTests
@end


// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGAlignContentTest.html
@implementation YogaTests (YGAlignContentTest)

- (void)test_align_content_flex_start {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 130,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 130,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_x": 50
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_y": 10
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_x": 50,
                "_y": 10
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_y": 20
            }
        ]
    }
    )");
}

- (void)test_align_content_flex_start_without_height_on_children {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 0
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_y": 10,
                "_height": 0
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_y": 10
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_y": 20,
                "_height": 0
            }
        ]
    }
    )");
}

- (void)test_align_content_flex_start_with_flex {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 120,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-basis": "0%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-basis": "0%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-basis": "0%",
            "flex-grow": 1,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 120,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_height": 40
            },
            {
                "width": 50,
                "height": 10,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 40,
                "_height": 40
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_y": 80,
                "_height": 0
            },
            {
                "width": 50,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "_y": 80,
                "_height": 40
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_y": 120,
                "_height": 0
            }
        ]
    }
    )");
}

- (void)test_align_content_flex_end {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "end",
        "wrap": "wrap",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "end",
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_y": 10
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_y": 20
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_y": 30
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_y": 40
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 0
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 0
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 0
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 0
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 0
            }
        ]
    }
    )");
}

- (void)test_align_content_spacebetween {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 130,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "space-between",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 130,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "space-between",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_x": 50
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_y": 45
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_x": 50,
                "_y": 45
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_y": 90
            }
        ]
    }
    )");
}

- (void)test_align_content_spacearound {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 140,
        "height": 120,
        "flex-shrink": 0,
        "align-content": "space-around",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 140,
        "height": 120,
        "flex-shrink": 0,
        "align-content": "space-around",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_y": 15
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_x": 50,
                "_y": 15
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_y": 55
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_x": 50,
                "_y": 55
            },
            {
                "width": 50,
                "height": 10,
                "flex-shrink": 0,
                "_y": 95
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_height": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 100,
                "_height": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_y": 50,
                "_height": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_y": 50,
                "_height": 50
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch_row_with_children {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "flex-basis": "0%",
                        "flex-grow": 1,
                        "flex-shrink": 1,
                        "_width": 50,
                        "_height": 50
                    }
                ],
                "_height": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_height": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 100,
                "_height": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_y": 50,
                "_height": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_y": 50,
                "_height": 50
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch_row_with_flex {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-basis": "0%",
            "flex-grow": 1,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-basis": "0%",
            "flex-grow": 1,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 100
            },
            {
                "width": 50,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "_x": 50,
                "_width": 0,
                "_height": 100
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_height": 100
            },
            {
                "width": 50,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "_x": 100,
                "_width": 0,
                "_height": 100
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 100,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch_row_with_flex_no_shrink {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-basis": "0%",
            "flex-grow": 1,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-basis": "0%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 100
            },
            {
                "width": 50,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "_x": 50,
                "_width": 0,
                "_height": 100
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_height": 100
            },
            {
                "width": 50,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 100,
                "_width": 0,
                "_height": 100
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 100,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch_row_with_margin {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "margin-top": 10,
            "margin-right": 10,
            "margin-bottom": 10,
            "margin-left": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "margin-top": 10,
            "margin-right": 10,
            "margin-bottom": 10,
            "margin-left": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 40
            },
            {
                "width": 50,
                "margin-top": 10,
                "margin-right": 10,
                "margin-bottom": 10,
                "margin-left": 10,
                "flex-shrink": 0,
                "_x": 60,
                "_y": 10,
                "_height": 20
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_y": 40,
                "_height": 40
            },
            {
                "width": 50,
                "margin-top": 10,
                "margin-right": 10,
                "margin-bottom": 10,
                "margin-left": 10,
                "flex-shrink": 0,
                "_x": 60,
                "_y": 50,
                "_height": 20
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_y": 80,
                "_height": 20
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch_row_with_padding {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "padding-top": 10,
            "padding-right": 10,
            "padding-bottom": 10,
            "padding-left": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "padding-top": 10,
            "padding-right": 10,
            "padding-bottom": 10,
            "padding-left": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 50
            },
            {
                "width": 50,
                "padding-top": 10,
                "padding-right": 10,
                "padding-bottom": 10,
                "padding-left": 10,
                "flex-shrink": 0,
                "_x": 50,
                "_height": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 100,
                "_height": 50
            },
            {
                "width": 50,
                "padding-top": 10,
                "padding-right": 10,
                "padding-bottom": 10,
                "padding-left": 10,
                "flex-shrink": 0,
                "_y": 50,
                "_height": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_y": 50,
                "_height": 50
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch_row_with_single_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 100
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch_row_with_fixed_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 60,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 80
            },
            {
                "width": 50,
                "height": 60,
                "flex-shrink": 0,
                "_x": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 100,
                "_height": 80
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_y": 80,
                "_height": 20
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_y": 80,
                "_height": 20
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch_row_with_max_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "max-height": 20,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 50
            },
            {
                "width": 50,
                "max-height": 20,
                "flex-shrink": 0,
                "_x": 50,
                "_height": 20
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 100,
                "_height": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_y": 50,
                "_height": 50
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_y": 50,
                "_height": 50
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch_row_with_min_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "min-height": 80,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 90
            },
            {
                "width": 50,
                "min-height": 80,
                "flex-shrink": 0,
                "_x": 50,
                "_height": 90
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 100,
                "_height": 90
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_y": 90,
                "_height": 10
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_y": 90,
                "_height": 10
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 150,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 50,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 50,
            "flex-basis": "0%",
            "flex-grow": 1,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 150,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "height": 50,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "flex-basis": "0%",
                        "flex-grow": 1,
                        "flex-shrink": 1,
                        "_width": 50,
                        "_height": 50
                    }
                ],
                "_width": 50
            },
            {
                "height": 50,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "_y": 50,
                "_width": 50,
                "_height": 0
            },
            {
                "height": 50,
                "flex-shrink": 0,
                "_y": 50,
                "_width": 50
            },
            {
                "height": 50,
                "flex-shrink": 0,
                "_y": 100,
                "_width": 50
            },
            {
                "height": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_width": 50
            }
        ]
    }
    )");
}

- (void)test_align_content_stretch_is_not_overriding_align_items {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "flex-shrink": 0,
        "align-content": "stretch",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "height": 100,
            "flex-shrink": 0,
            "align-items": "center",
            "align-content": "stretch",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 10,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "flex-shrink": 0,
        "align-content": "stretch",
        "direction": "vertical",
        "children": [
            {
                "width": 100,
                "height": 100,
                "flex-shrink": 0,
                "align-items": "center",
                "align-content": "stretch",
                "direction": "horizontal",
                "children": [
                    {
                        "width": 10,
                        "height": 10,
                        "flex-shrink": 0,
                        "_y": 45
                    }
                ]
            }
        ],
        "_width": 100,
        "_height": 100
    }
    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGAlignItemsTest.html
@implementation YogaTests (YGAlignItemsTest)

- (void)test_align_items_stretch {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "flex-shrink": 0,
                "_width": 100
            }
        ]
    }
    )");
}

- (void)test_align_items_center {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "height": 10,
                "flex-shrink": 0,
                "_x": 45
            }
        ]
    }
    )");
}

- (void)test_align_items_flex_start {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "start",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "start",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "height": 10,
                "flex-shrink": 0
            }
        ]
    }
    )");
}

- (void)test_align_items_flex_end {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "end",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "end",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "height": 10,
                "flex-shrink": 0,
                "_x": 90
            }
        ]
    }
    )");
}

- (void)test_align_baseline {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "_x": 50,
//                "_y": 30
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 50,
//                        "height": 10,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_x": 50,
//                "_y": 40
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_child_multiline {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 60,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 25,
            "flex-shrink": 0,
            "align-content": "start",
            "wrap": "wrap",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 25,
                "height": 20,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 25,
                "height": 10,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 25,
                "height": 20,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 25,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 60,
//                "flex-shrink": 0
//            },
//            {
//                "width": 50,
//                "height": 25,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "wrap": "wrap",
//                "direction": "horizontal",
//                "children": [
//                    {
//                        "width": 25,
//                        "height": 20,
//                        "flex-shrink": 0
//                    },
//                    {
//                        "width": 25,
//                        "height": 10,
//                        "flex-shrink": 0,
//                        "_x": 25
//                    },
//                    {
//                        "width": 25,
//                        "height": 20,
//                        "flex-shrink": 0,
//                        "_y": 20
//                    },
//                    {
//                        "width": 25,
//                        "height": 10,
//                        "flex-shrink": 0,
//                        "_x": 25,
//                        "_y": 20
//                    }
//                ],
//                "_x": 50,
//                "_y": 40
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_child_multiline_override {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 60,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 25,
            "flex-shrink": 0,
            "align-content": "start",
            "wrap": "wrap",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 25,
                "height": 20,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 25,
                "height": 10,
                "flex-shrink": 0,
                "align-self": "baseline"
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 25,
                "height": 20,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 25,
                "height": 10,
                "flex-shrink": 0,
                "align-self": "baseline"
              }
            }
          ]
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 60,
//                "flex-shrink": 0
//            },
//            {
//                "width": 50,
//                "height": 25,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "wrap": "wrap",
//                "direction": "horizontal",
//                "children": [
//                    {
//                        "width": 25,
//                        "height": 20,
//                        "flex-shrink": 0
//                    },
//                    {
//                        "width": 25,
//                        "height": 10,
//                        "flex-shrink": 0,
//                        "align-self": "baseline",
//                        "_x": 25
//                    },
//                    {
//                        "width": 25,
//                        "height": 20,
//                        "flex-shrink": 0,
//                        "_y": 20
//                    },
//                    {
//                        "width": 25,
//                        "height": 10,
//                        "flex-shrink": 0,
//                        "align-self": "baseline",
//                        "_x": 25,
//                        "_y": 20
//                    }
//                ],
//                "_x": 50,
//                "_y": 50
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_child_multiline_no_override_on_secondline {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 60,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 25,
            "flex-shrink": 0,
            "align-content": "start",
            "wrap": "wrap",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 25,
                "height": 20,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 25,
                "height": 10,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 25,
                "height": 20,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 25,
                "height": 10,
                "flex-shrink": 0,
                "align-self": "baseline"
              }
            }
          ]
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 60,
//                "flex-shrink": 0
//            },
//            {
//                "width": 50,
//                "height": 25,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "wrap": "wrap",
//                "direction": "horizontal",
//                "children": [
//                    {
//                        "width": 25,
//                        "height": 20,
//                        "flex-shrink": 0
//                    },
//                    {
//                        "width": 25,
//                        "height": 10,
//                        "flex-shrink": 0,
//                        "_x": 25
//                    },
//                    {
//                        "width": 25,
//                        "height": 20,
//                        "flex-shrink": 0,
//                        "_y": 20
//                    },
//                    {
//                        "width": 25,
//                        "height": 10,
//                        "flex-shrink": 0,
//                        "align-self": "baseline",
//                        "_x": 25,
//                        "_y": 20
//                    }
//                ],
//                "_x": 50,
//                "_y": 40
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_child_top {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "top": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    // TODO 'baseline', 'top' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "top": 10,
//                "flex-shrink": 0,
//                "_y": 10
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 50,
//                        "height": 10,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_x": 50,
//                "_y": 40
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_child_top2 {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "top": 5,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    // TODO 'baseline', 'top' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "top": 5,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 50,
//                        "height": 10,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_x": 50,
//                "_y": 45
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_double_nested_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "height": 20,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "height": 15,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 50,
//                        "height": 20,
//                        "flex-shrink": 0
//                    }
//                ]
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 50,
//                        "height": 15,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_x": 50,
//                "_y": 5
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "direction": "vertical",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "_y": 50
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_child_margin {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-top": 5,
            "margin-right": 5,
            "margin-bottom": 5,
            "margin-left": 5,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "height": 10,
                "margin-top": 1,
                "margin-right": 1,
                "margin-bottom": 1,
                "margin-left": 1,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "margin-top": 5,
//                "margin-right": 5,
//                "margin-bottom": 5,
//                "margin-left": 5,
//                "flex-shrink": 0,
//                "_x": 5,
//                "_y": 5
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 50,
//                        "height": 10,
//                        "margin-top": 1,
//                        "margin-right": 1,
//                        "margin-bottom": 1,
//                        "margin-left": 1,
//                        "flex-shrink": 0,
//                        "_x": 1,
//                        "_y": 1
//                    }
//                ],
//                "_x": 60,
//                "_y": 44
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_child_padding {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "padding-top": 5,
        "padding-right": 5,
        "padding-bottom": 5,
        "padding-left": 5,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "padding-top": 5,
            "padding-right": 5,
            "padding-bottom": 5,
            "padding-left": 5,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "padding-top": 5,
//        "padding-right": 5,
//        "padding-bottom": 5,
//        "padding-left": 5,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0,
//                "_x": 5,
//                "_y": 5
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "padding-top": 5,
//                "padding-right": 5,
//                "padding-bottom": 5,
//                "padding-left": 5,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 50,
//                        "height": 10,
//                        "flex-shrink": 0,
//                        "_x": 5,
//                        "_y": 5
//                    }
//                ],
//                "_x": 55,
//                "_y": 40
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_multiline {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "wrap": "wrap",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 50,
//                        "height": 10,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_x": 50,
//                "_y": 40
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 50,
//                        "height": 10,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_y": 100
//            },
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0,
//                "_x": 50,
//                "_y": 60
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_multiline_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "wrap": "wrap",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 50,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 20,
                "height": 20,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 40,
            "height": 70,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 10,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "wrap": "wrap",
//        "direction": "vertical",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0
//            },
//            {
//                "width": 30,
//                "height": 50,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 20,
//                        "height": 20,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_y": 50
//            },
//            {
//                "width": 40,
//                "height": 70,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 10,
//                        "height": 10,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_x": 50
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "_x": 50,
//                "_y": 70
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_multiline_column2 {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "wrap": "wrap",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 50,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 20,
                "height": 20,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 40,
            "height": 70,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 10,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "wrap": "wrap",
//        "direction": "vertical",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0
//            },
//            {
//                "width": 30,
//                "height": 50,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 20,
//                        "height": 20,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_y": 50
//            },
//            {
//                "width": 40,
//                "height": 70,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 10,
//                        "height": 10,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_x": 50
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "_x": 50,
//                "_y": 70
//            }
//        ]
//    }
//    )");
}

- (void)test_align_baseline_multiline_row_and_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "baseline",
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-items": "baseline",
//        "align-content": "start",
//        "wrap": "wrap",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0
//            },
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 50,
//                        "height": 10,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_x": 50,
//                "_y": 40
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 50,
//                        "height": 10,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_y": 100
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "_x": 50,
//                "_y": 90
//            }
//        ]
//    }
//    )");
}

- (void)test_align_items_center_child_with_margin_bigger_than_parent {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-items": "center",
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 52,
                "height": 52,
                "margin-right": 10,
                "margin-left": 10,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 0,
                "align-items": "center",
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": 52,
                        "height": 52,
                        "margin-right": 10,
                        "margin-left": 10,
                        "flex-shrink": 0,
                        "_x": 10
                    }
                ],
                "_x": -10,
                "_width": 72,
                "_height": 52
            }
        ]
    }
    )");
}

- (void)test_align_items_flex_end_child_with_margin_bigger_than_parent {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-items": "end",
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 52,
                "height": 52,
                "margin-right": 10,
                "margin-left": 10,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 0,
                "align-items": "end",
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": 52,
                        "height": 52,
                        "margin-right": 10,
                        "margin-left": 10,
                        "flex-shrink": 0,
                        "_x": 10
                    }
                ],
                "_x": -10,
                "_width": 72,
                "_height": 52
            }
        ]
    }
    )");
}

- (void)test_align_items_center_child_without_margin_bigger_than_parent {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-items": "center",
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 72,
                "height": 72,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 0,
                "align-items": "center",
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": 72,
                        "height": 72,
                        "flex-shrink": 0
                    }
                ],
                "_x": -10,
                "_y": -10,
                "_width": 72,
                "_height": 72
            }
        ]
    }
    )");
}

- (void)test_align_items_flex_end_child_without_margin_bigger_than_parent {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-items": "end",
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 72,
                "height": 72,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 0,
                "align-items": "end",
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": 72,
                        "height": 72,
                        "flex-shrink": 0
                    }
                ],
                "_x": -10,
                "_y": -10,
                "_width": 72,
                "_height": 72
            }
        ]
    }
    )");
}

- (void)test_align_center_should_size_based_on_content {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "margin-top": 20,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 0,
            "flex-shrink": 1,
            "align-content": "start",
            "justify-content": "center",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "flex-grow": 1,
                "flex-shrink": 1,
                "align-content": "start",
                "direction": "vertical"
              },
              "children": [
                {
                  "style": {
                    "background-color": "#1aff0000",
                    "width": 20,
                    "height": 20,
                    "flex-shrink": 0
                  }
                }
              ]
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "margin-top": 20,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-grow": 0,
                "flex-shrink": 1,
                "align-content": "start",
                "justify-content": "center",
                "direction": "vertical",
                "children": [
                    {
                        "flex-grow": 1,
                        "flex-shrink": 1,
                        "align-content": "start",
                        "direction": "vertical",
                        "children": [
                            {
                                "width": 20,
                                "height": 20,
                                "flex-shrink": 0
                            }
                        ],
                        "_width": 20,
                        "_height": 20
                    }
                ],
                "_x": 40,
                "_width": 20,
                "_height": 20
            }
        ],
        "_y": 20
    }
    )");
}

- (void)test_align_strech_should_size_based_on_parent {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "margin-top": 20,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 0,
            "flex-shrink": 1,
            "align-content": "start",
            "justify-content": "center",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "flex-grow": 1,
                "flex-shrink": 1,
                "align-content": "start",
                "direction": "vertical"
              },
              "children": [
                {
                  "style": {
                    "background-color": "#1aff0000",
                    "width": 20,
                    "height": 20,
                    "flex-shrink": 0
                  }
                }
              ]
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "margin-top": 20,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-grow": 0,
                "flex-shrink": 1,
                "align-content": "start",
                "justify-content": "center",
                "direction": "vertical",
                "children": [
                    {
                        "flex-grow": 1,
                        "flex-shrink": 1,
                        "align-content": "start",
                        "direction": "vertical",
                        "children": [
                            {
                                "width": 20,
                                "height": 20,
                                "flex-shrink": 0
                            }
                        ],
                        "_width": 100,
                        "_height": 20
                    }
                ],
                "_width": 100,
                "_height": 20
            }
        ],
        "_y": 20
    }
    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGAlignSelfTest.html
@implementation YogaTests (YGAlignSelfTest)

- (void)test_align_self_center {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "height": 10,
            "flex-shrink": 0,
            "align-self": "center"
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "height": 10,
                "flex-shrink": 0,
                "align-self": "center",
                "_x": 45
            }
        ]
    }
    )");
}

- (void)test_align_self_flex_end {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "height": 10,
            "flex-shrink": 0,
            "align-self": "end"
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "height": 10,
                "flex-shrink": 0,
                "align-self": "end",
                "_x": 90
            }
        ]
    }
    )");
}

- (void)test_align_self_flex_start {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "height": 10,
            "flex-shrink": 0,
            "align-self": "start"
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "height": 10,
                "flex-shrink": 0,
                "align-self": "start"
            }
        ]
    }
    )");
}

- (void)test_align_self_flex_end_override_flex_start {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "start",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "height": 10,
            "flex-shrink": 0,
            "align-self": "end"
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "start",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "height": 10,
                "flex-shrink": 0,
                "align-self": "end",
                "_x": 90
            }
        ]
    }
    )");
}

- (void)test_align_self_baseline {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0,
            "align-self": "baseline"
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 20,
            "flex-shrink": 0,
            "align-self": "baseline",
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    // TODO 'baseline' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 100,
//        "flex-shrink": 0,
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": 50,
//                "height": 50,
//                "flex-shrink": 0,
//                "align-self": "baseline"
//            },
//            {
//                "width": 50,
//                "height": 20,
//                "flex-shrink": 0,
//                "align-self": "baseline",
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "width": 50,
//                        "height": 10,
//                        "flex-shrink": 0
//                    }
//                ],
//                "_x": 50,
//                "_y": 40
//            }
//        ]
//    }
//    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGBorderTest.html
@implementation YogaTests (YGBorderTest)

- (void)test_border_no_size {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "flex-shrink": 0
      }
    }
    */
    XCTAssertLayout(@R"(
    {
        "flex-shrink": 0,
        "_width": 0,
        "_height": 0
    }
    )");
}

- (void)test_border_container_match_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "height": 10,
                "flex-shrink": 0
            }
        ],
        "_width": 10,
        "_height": 10
    }
    )");
}

- (void)test_border_flex_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_border_stretch_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "flex-shrink": 0,
                "_width": 100
            }
        ]
    }
    )");
}

- (void)test_border_center_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "height": 10,
                "flex-shrink": 0,
                "_x": 45,
                "_y": 45
            }
        ]
    }
    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGDimensionTest.html
@implementation YogaTests (YGDimensionTest)

- (void)test_wrap_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "height": 100,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 100,
                "height": 100,
                "flex-shrink": 0
            }
        ],
        "_width": 100,
        "_height": 100
    }
    )");
}

- (void)test_wrap_grandchild {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 100,
                "height": 100,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": 100,
                        "height": 100,
                        "flex-shrink": 0
                    }
                ],
                "_width": 100,
                "_height": 100
            }
        ],
        "_width": 100,
        "_height": 100
    }
    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGFlexDirectionTest.html
@implementation YogaTests (YGFlexDirectionTest)

- (void)test_flex_direction_column_no_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "flex-shrink": 0,
                "_width": 100
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 10,
                "_width": 100
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 20,
                "_width": 100
            }
        ],
        "_height": 30
    }
    )");
}

- (void)test_flex_direction_row_no_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "width": 10,
                "flex-shrink": 0,
                "_height": 100
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 10,
                "_height": 100
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 20,
                "_height": 100
            }
        ],
        "_width": 30
    }
    )");
}

- (void)test_flex_direction_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "flex-shrink": 0,
                "_width": 100
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 10,
                "_width": 100
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 20,
                "_width": 100
            }
        ]
    }
    )");
}

- (void)test_flex_direction_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "width": 10,
                "flex-shrink": 0,
                "_height": 100
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 10,
                "_height": 100
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 20,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_flex_direction_column_reverse {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical-reverse"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical-reverse",
        "children": [
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 90,
                "_width": 100
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 80,
                "_width": 100
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 70,
                "_width": 100
            }
        ]
    }
    )");
}

- (void)test_flex_direction_row_reverse {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal-reverse"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal-reverse",
        "children": [
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 90,
                "_height": 100
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 80,
                "_height": 100
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 70,
                "_height": 100
            }
        ]
    }
    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGFlexTest.html
@implementation YogaTests (YGFlexTest)

- (void)test_flex_basis_flex_grow_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": 50,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-basis": 50,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 100,
                "_height": 75
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 75,
                "_width": 100,
                "_height": 25
            }
        ]
    }
    )");
}

- (void)test_flex_basis_flex_grow_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": 50,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "flex-basis": 50,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 75,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 75,
                "_width": 25,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_flex_basis_flex_shrink_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": 100,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-basis": 100,
                "flex-shrink": 1,
                "_width": 100,
                "_height": 50
            },
            {
                "flex-basis": 50,
                "flex-shrink": 0,
                "_y": 50,
                "_width": 100,
                "_height": 50
            }
        ]
    }
    )");
}

- (void)test_flex_basis_flex_shrink_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": 100,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "flex-basis": 100,
                "flex-shrink": 1,
                "_width": 50,
                "_height": 100
            },
            {
                "flex-basis": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_width": 50,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_flex_shrink_to_zero {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "height": 75,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "height": 75,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 1,
                "_y": 50,
                "_height": 0
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_y": 50
            }
        ],
        "_width": 50
    }
    )");
}

- (void)test_flex_basis_overrides_main_size {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 20,
            "flex-basis": 50,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 20,
                "flex-basis": 50,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 100,
                "_height": 60
            },
            {
                "height": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 60,
                "_width": 100,
                "_height": 20
            },
            {
                "height": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 80,
                "_width": 100,
                "_height": 20
            }
        ]
    }
    )");
}

- (void)test_flex_grow_shrink_at_most {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "flex-grow": 1,
                "flex-shrink": 1
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "flex-grow": 1,
                        "flex-shrink": 1,
                        "_width": 100,
                        "_height": 0
                    }
                ],
                "_width": 100,
                "_height": 0
            }
        ]
    }
    )");
}

- (void)test_flex_grow_less_than_factor_one {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": 40,
            "flex-grow": 0.2,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 0.2,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 0.4,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-basis": 40,
                "flex-grow": 0.2,
                "flex-shrink": 0,
                "_width": 200,
                "_height": 132
            },
            {
                "flex-grow": 0.2,
                "flex-shrink": 0,
                "_y": 132,
                "_width": 200,
                "_height": 92
            },
            {
                "flex-grow": 0.4,
                "flex-shrink": 0,
                "_y": 224,
                "_width": 200,
                "_height": 184
            }
        ]
    }
    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGFlexWrapTest.html
@implementation YogaTests (YGFlexWrapTest)

- (void)test_wrap_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_y": 30
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_y": 60
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_x": 30
            }
        ],
        "_width": 30
    }
    )");
}

- (void)test_wrap_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_x": 30
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_x": 60
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_y": 30
            }
        ],
        "_height": 60
    }
    )");
}

- (void)test_wrap_row_align_items_flex_end {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "flex-shrink": 0,
        "align-items": "end",
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 20,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "flex-shrink": 0,
        "align-items": "end",
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 30,
                "height": 10,
                "flex-shrink": 0,
                "_y": 20
            },
            {
                "width": 30,
                "height": 20,
                "flex-shrink": 0,
                "_x": 30,
                "_y": 10
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_x": 60
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_y": 30
            }
        ],
        "_height": 60
    }
    )");
}

- (void)test_wrap_row_align_items_center {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 20,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 30,
                "height": 10,
                "flex-shrink": 0,
                "_y": 10
            },
            {
                "width": 30,
                "height": 20,
                "flex-shrink": 0,
                "_x": 30,
                "_y": 5
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_x": 60
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_y": 30
            }
        ],
        "_height": 60
    }
    )");
}

- (void)test_flex_wrap_children_with_min_main_overriding_flex_basis {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 50,
            "min-width": 55,
            "flex-basis": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 50,
            "min-width": 55,
            "flex-basis": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "height": 50,
                "min-width": 55,
                "flex-basis": 50,
                "flex-shrink": 0,
                "_width": 55
            },
            {
                "height": 50,
                "min-width": 55,
                "flex-basis": 50,
                "flex-shrink": 0,
                "_y": 50,
                "_width": 55
            }
        ],
        "_height": 100
    }
    )");
}

- (void)test_flex_wrap_wrap_to_child_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-items": "start",
            "align-content": "start",
            "wrap": "wrap",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 100,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical"
              },
              "children": [
                {
                  "style": {
                    "background-color": "#1aff0000",
                    "width": 100,
                    "height": 100,
                    "flex-shrink": 0
                  }
                }
              ]
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "height": 100,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 0,
                "align-items": "start",
                "align-content": "start",
                "wrap": "wrap",
                "direction": "horizontal",
                "children": [
                    {
                        "width": 100,
                        "flex-shrink": 0,
                        "align-content": "start",
                        "direction": "vertical",
                        "children": [
                            {
                                "width": 100,
                                "height": 100,
                                "flex-shrink": 0
                            }
                        ],
                        "_height": 100
                    }
                ],
                "_width": 100,
                "_height": 100
            },
            {
                "width": 100,
                "height": 100,
                "flex-shrink": 0,
                "_y": 100
            }
        ],
        "_width": 100,
        "_height": 200
    }
    )");
}

- (void)test_flex_wrap_align_stretch_fits_one_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 150,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "flex-shrink": 0,
                "_height": 100
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_wrap_reverse_row_align_content_flex_start {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap-reverse",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 20,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 40,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap-reverse",
        "direction": "horizontal",
        "children": [
            {
                "width": 30,
                "height": 10,
                "flex-shrink": 0,
                "_y": 70
            },
            {
                "width": 30,
                "height": 20,
                "flex-shrink": 0,
                "_x": 30,
                "_y": 60
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_x": 60,
                "_y": 50
            },
            {
                "width": 30,
                "height": 40,
                "flex-shrink": 0,
                "_y": 10
            },
            {
                "width": 30,
                "height": 50,
                "flex-shrink": 0,
                "_x": 30
            }
        ],
        "_height": 80
    }
    )");
}

- (void)test_wrap_reverse_row_align_content_center {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "flex-shrink": 0,
        "align-content": "center",
        "wrap": "wrap-reverse",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 20,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 40,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "flex-shrink": 0,
        "align-content": "center",
        "wrap": "wrap-reverse",
        "direction": "horizontal",
        "children": [
            {
                "width": 30,
                "height": 10,
                "flex-shrink": 0,
                "_y": 70
            },
            {
                "width": 30,
                "height": 20,
                "flex-shrink": 0,
                "_x": 30,
                "_y": 60
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_x": 60,
                "_y": 50
            },
            {
                "width": 30,
                "height": 40,
                "flex-shrink": 0,
                "_y": 10
            },
            {
                "width": 30,
                "height": 50,
                "flex-shrink": 0,
                "_x": 30
            }
        ],
        "_height": 80
    }
    )");
}

- (void)test_wrap_reverse_row_single_line_different_size {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 300,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap-reverse",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 20,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 40,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 300,
        "flex-shrink": 0,
        "align-content": "start",
        "wrap": "wrap-reverse",
        "direction": "horizontal",
        "children": [
            {
                "width": 30,
                "height": 10,
                "flex-shrink": 0,
                "_y": 40
            },
            {
                "width": 30,
                "height": 20,
                "flex-shrink": 0,
                "_x": 30,
                "_y": 30
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_x": 60,
                "_y": 20
            },
            {
                "width": 30,
                "height": 40,
                "flex-shrink": 0,
                "_x": 90,
                "_y": 10
            },
            {
                "width": 30,
                "height": 50,
                "flex-shrink": 0,
                "_x": 120
            }
        ],
        "_height": 50
    }
    )");
}

- (void)test_wrap_reverse_row_align_content_stretch {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap-reverse",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 20,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 40,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "flex-shrink": 0,
        "align-content": "stretch",
        "wrap": "wrap-reverse",
        "direction": "horizontal",
        "children": [
            {
                "width": 30,
                "height": 10,
                "flex-shrink": 0,
                "_y": 70
            },
            {
                "width": 30,
                "height": 20,
                "flex-shrink": 0,
                "_x": 30,
                "_y": 60
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_x": 60,
                "_y": 50
            },
            {
                "width": 30,
                "height": 40,
                "flex-shrink": 0,
                "_y": 10
            },
            {
                "width": 30,
                "height": 50,
                "flex-shrink": 0,
                "_x": 30
            }
        ],
        "_height": 80
    }
    )");
}

- (void)test_wrap_reverse_row_align_content_space_around {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "flex-shrink": 0,
        "align-content": "space-around",
        "wrap": "wrap-reverse",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 20,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 40,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "flex-shrink": 0,
        "align-content": "space-around",
        "wrap": "wrap-reverse",
        "direction": "horizontal",
        "children": [
            {
                "width": 30,
                "height": 10,
                "flex-shrink": 0,
                "_y": 70
            },
            {
                "width": 30,
                "height": 20,
                "flex-shrink": 0,
                "_x": 30,
                "_y": 60
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_x": 60,
                "_y": 50
            },
            {
                "width": 30,
                "height": 40,
                "flex-shrink": 0,
                "_y": 10
            },
            {
                "width": 30,
                "height": 50,
                "flex-shrink": 0,
                "_x": 30
            }
        ],
        "_height": 80
    }
    )");
}

- (void)test_wrap_reverse_column_fixed_size {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "wrap": "wrap-reverse",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 20,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 30,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 40,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 30,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "wrap": "wrap-reverse",
        "direction": "vertical",
        "children": [
            {
                "width": 30,
                "height": 10,
                "flex-shrink": 0,
                "_x": 170
            },
            {
                "width": 30,
                "height": 20,
                "flex-shrink": 0,
                "_x": 170,
                "_y": 10
            },
            {
                "width": 30,
                "height": 30,
                "flex-shrink": 0,
                "_x": 170,
                "_y": 30
            },
            {
                "width": 30,
                "height": 40,
                "flex-shrink": 0,
                "_x": 170,
                "_y": 60
            },
            {
                "width": 30,
                "height": 50,
                "flex-shrink": 0,
                "_x": 140
            }
        ]
    }
    )");
}

- (void)test_wrapped_row_within_align_items_center {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-content": "start",
            "wrap": "wrap",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 150,
                "height": 80,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 80,
                "height": 80,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 0,
                "align-content": "start",
                "wrap": "wrap",
                "direction": "horizontal",
                "children": [
                    {
                        "width": 150,
                        "height": 80,
                        "flex-shrink": 0
                    },
                    {
                        "width": 80,
                        "height": 80,
                        "flex-shrink": 0,
                        "_y": 80
                    }
                ],
                "_width": 200,
                "_height": 160
            }
        ]
    }
    )");
}

- (void)test_wrapped_row_within_align_items_flex_start {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "start",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-content": "start",
            "wrap": "wrap",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 150,
                "height": 80,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 80,
                "height": 80,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "start",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 0,
                "align-content": "start",
                "wrap": "wrap",
                "direction": "horizontal",
                "children": [
                    {
                        "width": 150,
                        "height": 80,
                        "flex-shrink": 0
                    },
                    {
                        "width": 80,
                        "height": 80,
                        "flex-shrink": 0,
                        "_y": 80
                    }
                ],
                "_width": 200,
                "_height": 160
            }
        ]
    }
    )");
}

- (void)test_wrapped_row_within_align_items_flex_end {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "end",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-content": "start",
            "wrap": "wrap",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 150,
                "height": 80,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 80,
                "height": 80,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "end",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 0,
                "align-content": "start",
                "wrap": "wrap",
                "direction": "horizontal",
                "children": [
                    {
                        "width": 150,
                        "height": 80,
                        "flex-shrink": 0
                    },
                    {
                        "width": 80,
                        "height": 80,
                        "flex-shrink": 0,
                        "_y": 80
                    }
                ],
                "_width": 200,
                "_height": 160
            }
        ]
    }
    )");
}

- (void)test_wrapped_column_max_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 700,
        "height": 500,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "center",
        "justify-content": "center",
        "wrap": "wrap",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "height": 500,
            "max-height": 200,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 200,
            "height": 200,
            "margin-top": 20,
            "margin-right": 20,
            "margin-bottom": 20,
            "margin-left": 20,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "height": 100,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 700,
        "height": 500,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "center",
        "justify-content": "center",
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "width": 100,
                "height": 500,
                "max-height": 200,
                "flex-shrink": 0,
                "_x": 250,
                "_y": 30,
                "_height": 200
            },
            {
                "width": 200,
                "height": 200,
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "flex-shrink": 0,
                "_x": 200,
                "_y": 250
            },
            {
                "width": 100,
                "height": 100,
                "flex-shrink": 0,
                "_x": 420,
                "_y": 200
            }
        ]
    }
    )");
}

- (void)test_wrapped_column_max_height_flex {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 700,
        "height": 500,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "center",
        "justify-content": "center",
        "wrap": "wrap",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "height": 500,
            "max-height": 200,
            "flex-basis": "0%",
            "flex-grow": 1,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 200,
            "height": 200,
            "flex-basis": "0%",
            "margin-top": 20,
            "margin-right": 20,
            "margin-bottom": 20,
            "margin-left": 20,
            "flex-grow": 1,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "height": 100,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 700,
        "height": 500,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "center",
        "justify-content": "center",
        "wrap": "wrap",
        "direction": "vertical",
        "children": [
            {
                "width": 100,
                "height": 500,
                "max-height": 200,
                "flex-basis": "0%",
                "flex-grow": 1,
                "flex-shrink": 1,
                "_x": 300,
                "_height": 180
            },
            {
                "width": 200,
                "height": 200,
                "flex-basis": "0%",
                "margin-top": 20,
                "margin-right": 20,
                "margin-bottom": 20,
                "margin-left": 20,
                "flex-grow": 1,
                "flex-shrink": 1,
                "_x": 250,
                "_y": 200,
                "_height": 180
            },
            {
                "width": 100,
                "height": 100,
                "flex-shrink": 0,
                "_x": 300,
                "_y": 400
            }
        ]
    }
    )");
}

- (void)test_wrap_nodes_with_content_sizing_overflowing_margin {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 500,
        "height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 85,
            "flex-shrink": 0,
            "align-content": "start",
            "wrap": "wrap",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical"
              },
              "children": [
                {
                  "style": {
                    "background-color": "#1aff0000",
                    "width": 40,
                    "height": 40,
                    "flex-shrink": 0
                  }
                }
              ]
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "margin-right": 10,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical"
              },
              "children": [
                {
                  "style": {
                    "background-color": "#1aff0000",
                    "width": 40,
                    "height": 40,
                    "flex-shrink": 0
                  }
                }
              ]
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 500,
        "height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 85,
                "flex-shrink": 0,
                "align-content": "start",
                "wrap": "wrap",
                "direction": "horizontal",
                "children": [
                    {
                        "flex-shrink": 0,
                        "align-content": "start",
                        "direction": "vertical",
                        "children": [
                            {
                                "width": 40,
                                "height": 40,
                                "flex-shrink": 0
                            }
                        ],
                        "_width": 40,
                        "_height": 40
                    },
                    {
                        "margin-right": 10,
                        "flex-shrink": 0,
                        "align-content": "start",
                        "direction": "vertical",
                        "children": [
                            {
                                "width": 40,
                                "height": 40,
                                "flex-shrink": 0
                            }
                        ],
                        "_y": 40,
                        "_width": 40,
                        "_height": 40
                    }
                ],
                "_height": 80
            }
        ]
    }
    )");
}

- (void)test_wrap_nodes_with_content_sizing_margin_cross {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 500,
        "height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 70,
            "flex-shrink": 0,
            "align-content": "start",
            "wrap": "wrap",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical"
              },
              "children": [
                {
                  "style": {
                    "background-color": "#1aff0000",
                    "width": 40,
                    "height": 40,
                    "flex-shrink": 0
                  }
                }
              ]
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "margin-top": 10,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical"
              },
              "children": [
                {
                  "style": {
                    "background-color": "#1aff0000",
                    "width": 40,
                    "height": 40,
                    "flex-shrink": 0
                  }
                }
              ]
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 500,
        "height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 70,
                "flex-shrink": 0,
                "align-content": "start",
                "wrap": "wrap",
                "direction": "horizontal",
                "children": [
                    {
                        "flex-shrink": 0,
                        "align-content": "start",
                        "direction": "vertical",
                        "children": [
                            {
                                "width": 40,
                                "height": 40,
                                "flex-shrink": 0
                            }
                        ],
                        "_width": 40,
                        "_height": 40
                    },
                    {
                        "margin-top": 10,
                        "flex-shrink": 0,
                        "align-content": "start",
                        "direction": "vertical",
                        "children": [
                            {
                                "width": 40,
                                "height": 40,
                                "flex-shrink": 0
                            }
                        ],
                        "_y": 50,
                        "_width": 40,
                        "_height": 40
                    }
                ],
                "_height": 90
            }
        ]
    }
    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGJustifyContentTest.html
@implementation YogaTests (YGJustifyContentTest)

- (void)test_justify_content_row_flex_start {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "width": 10,
                "flex-shrink": 0,
                "_height": 102
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 10,
                "_height": 102
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 20,
                "_height": 102
            }
        ]
    }
    )");
}

- (void)test_justify_content_row_flex_end {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "end",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "end",
        "direction": "horizontal",
        "children": [
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 72,
                "_height": 102
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 82,
                "_height": 102
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 92,
                "_height": 102
            }
        ]
    }
    )");
}

- (void)test_justify_content_row_center {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "horizontal",
        "children": [
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 36,
                "_height": 102
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 46,
                "_height": 102
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 56,
                "_height": 102
            }
        ]
    }
    )");
}

- (void)test_justify_content_row_space_between {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "space-between",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "space-between",
        "direction": "horizontal",
        "children": [
            {
                "width": 10,
                "flex-shrink": 0,
                "_height": 102
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 46,
                "_height": 102
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 92,
                "_height": 102
            }
        ]
    }
    )");
}

- (void)test_justify_content_row_space_around {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "space-around",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "space-around",
        "direction": "horizontal",
        "children": [
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 12,
                "_height": 102
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 46,
                "_height": 102
            },
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 80,
                "_height": 102
            }
        ]
    }
    )");
}

- (void)test_justify_content_column_flex_start {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "flex-shrink": 0,
                "_width": 102
            },
            {
                "flex-shrink": 0,
                "_y": 10,
                "_width": 102,
                "_height": 0
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 10,
                "_width": 102
            }
        ]
    }
    )");
}

- (void)test_justify_content_column_flex_end {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "end",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "end",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 72,
                "_width": 102
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 82,
                "_width": 102
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 92,
                "_width": 102
            }
        ]
    }
    )");
}

- (void)test_justify_content_column_center {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 36,
                "_width": 102
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 46,
                "_width": 102
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 56,
                "_width": 102
            }
        ]
    }
    )");
}

- (void)test_justify_content_column_space_between {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "space-between",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "space-between",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "flex-shrink": 0,
                "_width": 102
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 46,
                "_width": 102
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 92,
                "_width": 102
            }
        ]
    }
    )");
}

- (void)test_justify_content_column_space_around {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "space-around",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 102,
        "height": 102,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "space-around",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 12,
                "_width": 102
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 46,
                "_width": 102
            },
            {
                "height": 10,
                "flex-shrink": 0,
                "_y": 80,
                "_width": 102
            }
        ]
    }
    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGMarginTest.html
@implementation YogaTests (YGMarginTest)

- (void)test_margin_start {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "width": 10,
                "flex-shrink": 0,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_margin_top {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "margin-top": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "margin-top": 10,
                "flex-shrink": 0,
                "_y": 10,
                "_width": 100
            }
        ]
    }
    )");
}

- (void)test_margin_end {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "end",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "end",
        "direction": "horizontal",
        "children": [
            {
                "width": 10,
                "flex-shrink": 0,
                "_x": 90,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_margin_bottom {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "end",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "margin-bottom": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "end",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "margin-bottom": 10,
                "flex-shrink": 0,
                "_y": 80,
                "_width": 100
            }
        ]
    }
    )");
}

- (void)test_margin_and_flex_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 100,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_margin_and_flex_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "margin-top": 10,
            "margin-bottom": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "margin-top": 10,
                "margin-bottom": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 10,
                "_width": 100,
                "_height": 80
            }
        ]
    }
    )");
}

- (void)test_margin_and_stretch_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "margin-top": 10,
            "margin-bottom": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "margin-top": 10,
                "margin-bottom": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 10,
                "_width": 100,
                "_height": 80
            }
        ]
    }
    )");
}

- (void)test_margin_and_stretch_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 100,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_margin_with_sibling_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 50,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 50,
                "_width": 50,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_margin_with_sibling_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "margin-bottom": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "margin-bottom": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 100,
                "_height": 45
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 55,
                "_width": 100,
                "_height": 45
            }
        ]
    }
    )");
}

- (void)test_margin_auto_bottom {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-bottom": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-bottom": "auto",
                "flex-shrink": 0,
                "_x": 75
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_x": 75,
                "_y": 150
            }
        ]
    }
    )");
}

- (void)test_margin_auto_top {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-top": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": "auto",
                "flex-shrink": 0,
                "_x": 75,
                "_y": 100
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_x": 75,
                "_y": 150
            }
        ]
    }
    )");
}

- (void)test_margin_auto_bottom_and_top {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-top": "auto",
            "margin-bottom": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": "auto",
                "margin-bottom": "auto",
                "flex-shrink": 0,
                "_x": 75,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_x": 75,
                "_y": 150
            }
        ]
    }
    )");
}

- (void)test_margin_auto_bottom_and_top_justify_center {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-top": "auto",
            "margin-bottom": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": "auto",
                "margin-bottom": "auto",
                "flex-shrink": 0,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_y": 150
            }
        ]
    }
    )");
}

- (void)test_margin_auto_mutiple_children_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-top": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-top": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": "auto",
                "flex-shrink": 0,
                "_x": 75,
                "_y": 25
            },
            {
                "width": 50,
                "height": 50,
                "margin-top": "auto",
                "flex-shrink": 0,
                "_x": 75,
                "_y": 100
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_x": 75,
                "_y": 150
            }
        ]
    }
    )");
}

- (void)test_margin_auto_mutiple_children_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-right": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-right": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-right": "auto",
                "flex-shrink": 0,
                "_y": 75
            },
            {
                "width": 50,
                "height": 50,
                "margin-right": "auto",
                "flex-shrink": 0,
                "_x": 75,
                "_y": 75
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_x": 150,
                "_y": 75
            }
        ]
    }
    )");
}

- (void)test_margin_auto_left_and_right_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-right": "auto",
            "margin-left": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-right": "auto",
                "margin-left": "auto",
                "flex-shrink": 0,
                "_x": 50,
                "_y": 75
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_x": 150,
                "_y": 75
            }
        ]
    }
    )");
}

- (void)test_margin_auto_left_and_right {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-right": "auto",
            "margin-left": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-right": "auto",
                "margin-left": "auto",
                "flex-shrink": 0,
                "_x": 75
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_y": 50
            }
        ]
    }
    )");
}

- (void)test_margin_auto_start_and_end_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_y": 75
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_y": 75
            }
        ]
    }
    )");
}

- (void)test_margin_auto_start_and_end {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_y": 50
            }
        ]
    }
    )");
}

- (void)test_margin_auto_left_and_right_column_and_center {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-right": "auto",
            "margin-left": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-right": "auto",
                "margin-left": "auto",
                "flex-shrink": 0,
                "_x": 75
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_x": 75,
                "_y": 50
            }
        ]
    }
    )");
}

- (void)test_margin_auto_left {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-left": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-left": "auto",
                "flex-shrink": 0,
                "_x": 150
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_x": 75,
                "_y": 50
            }
        ]
    }
    )");
}

- (void)test_margin_auto_right {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-right": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-right": "auto",
                "flex-shrink": 0
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_x": 75,
                "_y": 50
            }
        ]
    }
    )");
}

- (void)test_margin_auto_left_and_right_strech {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "stretch",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-right": "auto",
            "margin-left": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "stretch",
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-right": "auto",
                "margin-left": "auto",
                "flex-shrink": 0,
                "_x": 50
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_x": 150
            }
        ]
    }
    )");
}

- (void)test_margin_auto_top_and_bottom_strech {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "stretch",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "margin-top": "auto",
            "margin-bottom": "auto",
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "stretch",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "margin-top": "auto",
                "margin-bottom": "auto",
                "flex-shrink": 0,
                "_y": 50
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_y": 150
            }
        ]
    }
    )");
}

- (void)test_margin_should_not_be_part_of_max_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 250,
        "height": 250,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "height": 100,
            "max-height": 100,
            "margin-top": 20,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 250,
        "height": 250,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 100,
                "height": 100,
                "max-height": 100,
                "margin-top": 20,
                "flex-shrink": 0,
                "_y": 20
            }
        ]
    }
    )");
}

- (void)test_margin_should_not_be_part_of_max_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 250,
        "height": 250,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "height": 100,
            "max-width": 100,
            "margin-left": 20,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 250,
        "height": 250,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 100,
                "height": 100,
                "max-width": 100,
                "margin-left": 20,
                "flex-shrink": 0,
                "_x": 20
            }
        ]
    }
    )");
}

- (void)test_margin_auto_left_right_child_bigger_than_parent {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 72,
            "height": 72,
            "margin-right": "auto",
            "margin-left": "auto",
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "width": 72,
                "height": 72,
                "margin-right": "auto",
                "margin-left": "auto",
                "flex-shrink": 0,
                "_y": -10
            }
        ]
    }
    )");
}

- (void)test_margin_auto_left_child_bigger_than_parent {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 72,
            "height": 72,
            "margin-left": "auto",
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "width": 72,
                "height": 72,
                "margin-left": "auto",
                "flex-shrink": 0,
                "_y": -10
            }
        ]
    }
    )");
}

- (void)test_margin_fix_left_auto_right_child_bigger_than_parent {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 72,
            "height": 72,
            "margin-right": "auto",
            "margin-left": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "width": 72,
                "height": 72,
                "margin-right": "auto",
                "margin-left": 10,
                "flex-shrink": 0,
                "_x": 10,
                "_y": -10
            }
        ]
    }
    )");
}

- (void)test_margin_auto_left_fix_right_child_bigger_than_parent {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 72,
            "height": 72,
            "margin-right": 10,
            "margin-left": "auto",
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 52,
        "height": 52,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "width": 72,
                "height": 72,
                "margin-right": 10,
                "margin-left": "auto",
                "flex-shrink": 0,
                "_y": -10
            }
        ]
    }
    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGMinMaxDimensionTest.html
@implementation YogaTests (YGMinMaxDimensionTest)

- (void)test_max_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "max-width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "max-width": 50,
                "flex-shrink": 0,
                "_width": 50
            }
        ]
    }
    )");
}

- (void)test_max_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "max-height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "width": 10,
                "max-height": 50,
                "flex-shrink": 0,
                "_height": 50
            }
        ]
    }
    )");
}

- (void)test_min_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "min-height": 60,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "min-height": 60,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 100,
                "_height": 80
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 80,
                "_width": 100,
                "_height": 20
            }
        ]
    }
    )");
}

- (void)test_min_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "min-width": 60,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "min-width": 60,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 80,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 80,
                "_width": 20,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_justify_content_min_max {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "min-height": 100,
        "max-height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 60,
            "height": 60,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "min-height": 100,
        "max-height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "width": 60,
                "height": 60,
                "flex-shrink": 0,
                "_y": 20
            }
        ],
        "_height": 100
    }
    )");
}

- (void)test_align_items_min_max {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "height": 100,
        "min-width": 100,
        "max-width": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 60,
            "height": 60,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "height": 100,
        "min-width": 100,
        "max-width": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 60,
                "height": 60,
                "flex-shrink": 0,
                "_x": 20
            }
        ],
        "_width": 100
    }
    )");
}

- (void)test_justify_content_overflow_min_max {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "min-height": 100,
        "max-height": 110,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "min-height": 100,
        "max-height": 110,
        "flex-shrink": 0,
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_y": -20
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_y": 30
            },
            {
                "width": 50,
                "height": 50,
                "flex-shrink": 0,
                "_y": 80
            }
        ],
        "_width": 50,
        "_height": 110
    }
    )");
}

- (void)test_flex_grow_to_min {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "min-height": 100,
        "max-height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "min-height": 100,
        "max-height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-grow": 1,
                "flex-shrink": 1,
                "_width": 100,
                "_height": 50
            },
            {
                "height": 50,
                "flex-shrink": 0,
                "_y": 50,
                "_width": 100
            }
        ],
        "_height": 100
    }
    )");
}

- (void)test_flex_grow_in_at_most_container {
    /*
    {
      "style": {
        "background-color": "white",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "start",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "flex-basis": 0,
                "flex-grow": 1,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "start",
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "horizontal",
                "children": [
                    {
                        "flex-basis": 0,
                        "flex-grow": 1,
                        "flex-shrink": 0,
                        "_width": 0,
                        "_height": 0
                    }
                ],
                "_width": 0,
                "_height": 0
            }
        ]
    }
    )");
}

- (void)test_flex_grow_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 100,
            "flex-basis": 0,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "height": 100,
                "flex-basis": 0,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 0
            }
        ],
        "_width": 0,
        "_height": 100
    }
    )");
}

- (void)test_flex_grow_within_constrained_min_max_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "min-height": 100,
        "max-height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "min-height": 100,
        "max-height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 0,
                "_height": 50
            },
            {
                "height": 50,
                "flex-shrink": 0,
                "_y": 50,
                "_width": 0
            }
        ],
        "_width": 0,
        "_height": 100
    }
    )");
}

- (void)test_flex_grow_within_max_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "max-width": 100,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "height": 20,
                "flex-grow": 1,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "max-width": 100,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "horizontal",
                "children": [
                    {
                        "height": 20,
                        "flex-grow": 1,
                        "flex-shrink": 0,
                        "_width": 100
                    }
                ],
                "_width": 100,
                "_height": 20
            }
        ]
    }
    )");
}

- (void)test_flex_grow_within_constrained_max_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "max-width": 300,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "height": 20,
                "flex-grow": 1,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "max-width": 300,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "horizontal",
                "children": [
                    {
                        "height": 20,
                        "flex-grow": 1,
                        "flex-shrink": 0,
                        "_width": 200
                    }
                ],
                "_width": 200,
                "_height": 20
            }
        ]
    }
    )");
}

- (void)test_flex_root_ignored {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "min-height": 100,
        "max-height": 500,
        "flex-grow": 1,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": 200,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 100,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "min-height": 100,
        "max-height": 500,
        "flex-grow": 1,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-basis": 200,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 100,
                "_height": 200
            },
            {
                "height": 100,
                "flex-shrink": 0,
                "_y": 200,
                "_width": 100
            }
        ],
        "_height": 300
    }
    )");
}

- (void)test_flex_grow_root_minimized {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "min-height": 100,
        "max-height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "min-height": 100,
            "max-height": 500,
            "flex-grow": 1,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "flex-basis": 200,
                "flex-grow": 1,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "height": 100,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "min-height": 100,
        "max-height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "min-height": 100,
                "max-height": 500,
                "flex-grow": 1,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "flex-basis": 200,
                        "flex-grow": 1,
                        "flex-shrink": 0,
                        "_width": 100,
                        "_height": 200
                    },
                    {
                        "height": 100,
                        "flex-shrink": 0,
                        "_y": 200,
                        "_width": 100
                    }
                ],
                "_width": 100,
                "_height": 300
            }
        ],
        "_height": 300
    }
    )");
}

- (void)test_flex_grow_height_maximized {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "min-height": 100,
            "max-height": 500,
            "flex-grow": 1,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "flex-basis": 200,
                "flex-grow": 1,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "height": 100,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "min-height": 100,
                "max-height": 500,
                "flex-grow": 1,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "flex-basis": 200,
                        "flex-grow": 1,
                        "flex-shrink": 0,
                        "_width": 100,
                        "_height": 400
                    },
                    {
                        "height": 100,
                        "flex-shrink": 0,
                        "_y": 400,
                        "_width": 100
                    }
                ],
                "_width": 100,
                "_height": 500
            }
        ]
    }
    )");
}

- (void)test_flex_grow_within_constrained_min_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "height": 100,
        "min-width": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "height": 100,
        "min-width": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 50,
                "_height": 100
            },
            {
                "width": 50,
                "flex-shrink": 0,
                "_x": 50,
                "_height": 100
            }
        ],
        "_width": 100
    }
    )");
}

- (void)test_flex_grow_within_constrained_min_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "min-height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "min-height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 0,
                "_height": 50
            },
            {
                "height": 50,
                "flex-shrink": 0,
                "_y": 50,
                "_width": 0
            }
        ],
        "_width": 0,
        "_height": 100
    }
    )");
}

- (void)test_flex_grow_within_constrained_max_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 100,
            "max-width": 100,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "flex-basis": 100,
                "flex-shrink": 1
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 50,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 100,
                "max-width": 100,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "horizontal",
                "children": [
                    {
                        "flex-basis": 100,
                        "flex-shrink": 1,
                        "_width": 50,
                        "_height": 100
                    },
                    {
                        "width": 50,
                        "flex-shrink": 0,
                        "_x": 50,
                        "_height": 100
                    }
                ],
                "_width": 100
            }
        ],
        "_height": 100
    }
    )");
}

- (void)test_flex_grow_within_constrained_max_column {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "max-height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": 100,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 50,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "max-height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-basis": 100,
                "flex-shrink": 1,
                "_width": 100,
                "_height": 50
            },
            {
                "height": 50,
                "flex-shrink": 0,
                "_y": 50,
                "_width": 100
            }
        ],
        "_height": 100
    }
    )");
}

- (void)test_child_min_max_width_flexing {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 120,
        "height": 50,
        "flex-shrink": 0,
        "align-items": "stretch",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "min-width": 60,
            "flex-basis": 0,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "max-width": 20,
            "flex-basis": "50%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 120,
        "height": 50,
        "flex-shrink": 0,
        "align-items": "stretch",
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "min-width": 60,
                "flex-basis": 0,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 100,
                "_height": 50
            },
            {
                "max-width": 20,
                "flex-basis": "50%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 100,
                "_width": 20,
                "_height": 50
            }
        ]
    }
    )");
}

- (void)test_min_width_overrides_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 50,
        "min-width": 100,
        "flex-shrink": 0
      }
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 50,
        "min-width": 100,
        "flex-shrink": 0,
        "_width": 100,
        "_height": 0
    }
    )");
}

- (void)test_max_width_overrides_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "max-width": 100,
        "flex-shrink": 0
      }
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "max-width": 100,
        "flex-shrink": 0,
        "_width": 100,
        "_height": 0
    }
    )");
}

- (void)test_min_height_overrides_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "height": 50,
        "min-height": 100,
        "flex-shrink": 0
      }
    }
    */
    XCTAssertLayout(@R"(
    {
        "height": 50,
        "min-height": 100,
        "flex-shrink": 0,
        "_width": 0,
        "_height": 100
    }
    )");
}

- (void)test_max_height_overrides_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "height": 200,
        "max-height": 100,
        "flex-shrink": 0
      }
    }
    */
    XCTAssertLayout(@R"(
    {
        "height": 200,
        "max-height": 100,
        "flex-shrink": 0,
        "_width": 0,
        "_height": 100
    }
    )");
}

- (void)test_min_max_percent_no_width_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "start",
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "min-width": "10%",
            "min-height": "10%",
            "max-width": "10%",
            "max-height": "10%",
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "start",
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "min-width": "10%",
                "min-height": "10%",
                "max-width": "10%",
                "max-height": "10%",
                "flex-shrink": 0,
                "_width": 10,
                "_height": 10
            }
        ]
    }
    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGPaddingTest.html
@implementation YogaTests (YGPaddingTest)

- (void)test_padding_no_size {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "padding-top": 10,
        "padding-right": 10,
        "padding-bottom": 10,
        "padding-left": 10,
        "flex-shrink": 0
      }
    }
    */
    XCTAssertLayout(@R"(
    {
        "padding-top": 10,
        "padding-right": 10,
        "padding-bottom": 10,
        "padding-left": 10,
        "flex-shrink": 0,
        "_width": 20,
        "_height": 20
    }
    )");
}

- (void)test_padding_container_match_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "padding-top": 10,
        "padding-right": 10,
        "padding-bottom": 10,
        "padding-left": 10,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "padding-top": 10,
        "padding-right": 10,
        "padding-bottom": 10,
        "padding-left": 10,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "height": 10,
                "flex-shrink": 0,
                "_x": 10,
                "_y": 10
            }
        ],
        "_width": 30,
        "_height": 30
    }
    )");
}

- (void)test_padding_flex_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "padding-top": 10,
        "padding-right": 10,
        "padding-bottom": 10,
        "padding-left": 10,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "padding-top": 10,
        "padding-right": 10,
        "padding-bottom": 10,
        "padding-left": 10,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 10,
                "_y": 10,
                "_height": 80
            }
        ]
    }
    )");
}

- (void)test_padding_stretch_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "padding-top": 10,
        "padding-right": 10,
        "padding-bottom": 10,
        "padding-left": 10,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "padding-top": 10,
        "padding-right": 10,
        "padding-bottom": 10,
        "padding-left": 10,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 10,
                "flex-shrink": 0,
                "_x": 10,
                "_y": 10,
                "_width": 80
            }
        ]
    }
    )");
}

- (void)test_padding_center_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "padding-bottom": 20,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "height": 10,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "padding-bottom": 20,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "height": 10,
                "flex-shrink": 0,
                "_x": 45,
                "_y": 35
            }
        ]
    }
    )");
}

- (void)test_child_with_padding_align_end {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "end",
        "align-content": "start",
        "justify-content": "end",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "height": 100,
            "padding-top": 20,
            "padding-right": 20,
            "padding-bottom": 20,
            "padding-left": 20,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "end",
        "align-content": "start",
        "justify-content": "end",
        "direction": "vertical",
        "children": [
            {
                "width": 100,
                "height": 100,
                "padding-top": 20,
                "padding-right": 20,
                "padding-bottom": 20,
                "padding-left": 20,
                "flex-shrink": 0,
                "_x": 100,
                "_y": 100
            }
        ]
    }
    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGPercentageTest.html
@implementation YogaTests (YGPercentageTest)

- (void)test_percentage_width_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": "30%",
            "height": "30%",
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "width": "30%",
                "height": "30%",
                "flex-shrink": 0,
                "_width": 60,
                "_height": 60
            }
        ]
    }
    )");
}

- (void)test_percentage_position_left_top {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 400,
        "height": 400,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": "45%",
            "height": "55%",
            "top": "20%",
            "left": "10%",
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    // TODO 'left', 'top' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 400,
//        "height": 400,
//        "flex-shrink": 0,
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": "45%",
//                "height": "55%",
//                "top": "20%",
//                "left": "10%",
//                "flex-shrink": 0,
//                "_x": 40,
//                "_y": 80,
//                "_width": 180,
//                "_height": 220
//            }
//        ]
//    }
//    )");
}

- (void)test_percentage_position_bottom_right {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 500,
        "height": 500,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": "55%",
            "height": "15%",
            "right": "20%",
            "bottom": "10%",
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    // TODO 'right', 'bottom' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 500,
//        "height": 500,
//        "flex-shrink": 0,
//        "align-content": "start",
//        "direction": "horizontal",
//        "children": [
//            {
//                "width": "55%",
//                "height": "15%",
//                "right": "20%",
//                "bottom": "10%",
//                "flex-shrink": 0,
//                "_x": -100,
//                "_y": -50,
//                "_width": 275,
//                "_height": 75
//            }
//        ]
//    }
//    )");
}

- (void)test_percentage_flex_basis {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": "50%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": "25%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "flex-basis": "50%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 125,
                "_height": 200
            },
            {
                "flex-basis": "25%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 125,
                "_width": 75,
                "_height": 200
            }
        ]
    }
    )");
}

- (void)test_percentage_flex_basis_cross {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": "50%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": "25%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-basis": "50%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 200,
                "_height": 125
            },
            {
                "flex-basis": "25%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 125,
                "_width": 200,
                "_height": 75
            }
        ]
    }
    )");
}

- (void)test_percentage_flex_basis_cross_min_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "min-height": "60%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "min-height": "10%",
            "flex-grow": 2,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "min-height": "60%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 200,
                "_height": 140
            },
            {
                "min-height": "10%",
                "flex-grow": 2,
                "flex-shrink": 0,
                "_y": 140,
                "_width": 200,
                "_height": 60
            }
        ]
    }
    )");
}

- (void)test_percentage_flex_basis_main_max_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "max-height": "60%",
            "flex-basis": "10%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "max-height": "20%",
            "flex-basis": "10%",
            "flex-grow": 4,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "max-height": "60%",
                "flex-basis": "10%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 52,
                "_height": 120
            },
            {
                "max-height": "20%",
                "flex-basis": "10%",
                "flex-grow": 4,
                "flex-shrink": 0,
                "_x": 52,
                "_width": 148,
                "_height": 40
            }
        ]
    }
    )");
}

- (void)test_percentage_flex_basis_cross_max_height {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "max-height": "60%",
            "flex-basis": "10%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "max-height": "20%",
            "flex-basis": "10%",
            "flex-grow": 4,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "max-height": "60%",
                "flex-basis": "10%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 200,
                "_height": 120
            },
            {
                "max-height": "20%",
                "flex-basis": "10%",
                "flex-grow": 4,
                "flex-shrink": 0,
                "_y": 120,
                "_width": 200,
                "_height": 40
            }
        ]
    }
    )");
}

- (void)test_percentage_flex_basis_main_max_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "max-width": "60%",
            "flex-basis": "15%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "max-width": "20%",
            "flex-basis": "10%",
            "flex-grow": 4,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "max-width": "60%",
                "flex-basis": "15%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 120,
                "_height": 200
            },
            {
                "max-width": "20%",
                "flex-basis": "10%",
                "flex-grow": 4,
                "flex-shrink": 0,
                "_x": 120,
                "_width": 40,
                "_height": 200
            }
        ]
    }
    )");
}

- (void)test_percentage_flex_basis_cross_max_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "max-width": "60%",
            "flex-basis": "10%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "max-width": "20%",
            "flex-basis": "15%",
            "flex-grow": 4,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "max-width": "60%",
                "flex-basis": "10%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 120,
                "_height": 50
            },
            {
                "max-width": "20%",
                "flex-basis": "15%",
                "flex-grow": 4,
                "flex-shrink": 0,
                "_y": 50,
                "_width": 40,
                "_height": 150
            }
        ]
    }
    )");
}

- (void)test_percentage_flex_basis_main_min_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "min-width": "60%",
            "flex-basis": "15%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "min-width": "20%",
            "flex-basis": "10%",
            "flex-grow": 4,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "min-width": "60%",
                "flex-basis": "15%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 120,
                "_height": 200
            },
            {
                "min-width": "20%",
                "flex-basis": "10%",
                "flex-grow": 4,
                "flex-shrink": 0,
                "_x": 120,
                "_width": 80,
                "_height": 200
            }
        ]
    }
    )");
}

- (void)test_percentage_flex_basis_cross_min_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "min-width": "60%",
            "flex-basis": "10%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "min-width": "20%",
            "flex-basis": "15%",
            "flex-grow": 4,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "min-width": "60%",
                "flex-basis": "10%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 200,
                "_height": 50
            },
            {
                "min-width": "20%",
                "flex-basis": "15%",
                "flex-grow": 4,
                "flex-shrink": 0,
                "_y": 50,
                "_width": 200,
                "_height": 150
            }
        ]
    }
    )");
}

- (void)test_percentage_multiple_nested_with_padding_margin_and_percentage_values {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "min-width": "60%",
            "flex-basis": "10%",
            "margin-top": 5,
            "margin-right": 5,
            "margin-bottom": 5,
            "margin-left": 5,
            "padding-top": 3,
            "padding-right": 3,
            "padding-bottom": 3,
            "padding-left": 3,
            "flex-grow": 1,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": "50%",
                "margin-top": 5,
                "margin-right": 5,
                "margin-bottom": 5,
                "margin-left": 5,
                "padding-top": "3%",
                "padding-right": "3%",
                "padding-bottom": "3%",
                "padding-left": "3%",
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical"
              },
              "children": [
                {
                  "style": {
                    "background-color": "#1aff0000",
                    "width": "45%",
                    "margin-top": "5%",
                    "margin-right": "5%",
                    "margin-bottom": "5%",
                    "margin-left": "5%",
                    "padding-top": 3,
                    "padding-right": 3,
                    "padding-bottom": 3,
                    "padding-left": 3,
                    "flex-shrink": 0
                  }
                }
              ]
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "min-width": "20%",
            "flex-basis": "15%",
            "flex-grow": 4,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "min-width": "60%",
                "flex-basis": "10%",
                "margin-top": 5,
                "margin-right": 5,
                "margin-bottom": 5,
                "margin-left": 5,
                "padding-top": 3,
                "padding-right": 3,
                "padding-bottom": 3,
                "padding-left": 3,
                "flex-grow": 1,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": "50%",
                        "margin-top": 5,
                        "margin-right": 5,
                        "margin-bottom": 5,
                        "margin-left": 5,
                        "padding-top": "3%",
                        "padding-right": "3%",
                        "padding-bottom": "3%",
                        "padding-left": "3%",
                        "flex-shrink": 0,
                        "align-content": "start",
                        "direction": "vertical",
                        "children": [
                            {
                                "width": "45%",
                                "margin-top": "5%",
                                "margin-right": "5%",
                                "margin-bottom": "5%",
                                "margin-left": "5%",
                                "padding-top": 3,
                                "padding-right": 3,
                                "padding-bottom": 3,
                                "padding-left": 3,
                                "flex-shrink": 0,
                                "_x": 10,
                                "_y": 10,
                                "_width": 36,
                                "_height": 6
                            }
                        ],
                        "_x": 8,
                        "_y": 8,
                        "_width": 92,
                        "_height": 25
                    }
                ],
                "_x": 5,
                "_y": 5,
                "_width": 190,
                "_height": 48
            },
            {
                "min-width": "20%",
                "flex-basis": "15%",
                "flex-grow": 4,
                "flex-shrink": 0,
                "_y": 58,
                "_width": 200,
                "_height": 142
            }
        ]
    }
    )");
}

- (void)test_percentage_margin_should_calculate_based_only_on_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "margin-top": "10%",
            "margin-right": "10%",
            "margin-bottom": "10%",
            "margin-left": "10%",
            "flex-grow": 1,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 10,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "margin-top": "10%",
                "margin-right": "10%",
                "margin-bottom": "10%",
                "margin-left": "10%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": 10,
                        "height": 10,
                        "flex-shrink": 0
                    }
                ],
                "_x": 20,
                "_y": 20,
                "_width": 160,
                "_height": 60
            }
        ]
    }
    )");
}

- (void)test_percentage_padding_should_calculate_based_only_on_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "padding-top": "10%",
            "padding-right": "10%",
            "padding-bottom": "10%",
            "padding-left": "10%",
            "flex-grow": 1,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 10,
                "height": 10,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "padding-top": "10%",
                "padding-right": "10%",
                "padding-bottom": "10%",
                "padding-left": "10%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": 10,
                        "height": 10,
                        "flex-shrink": 0,
                        "_x": 20,
                        "_y": 20
                    }
                ],
                "_width": 200,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_percentage_absolute_position {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 100,
        "flex-shrink": 0
      }
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 100,
        "flex-shrink": 0
    }
    )");
}

- (void)test_percentage_width_height_undefined_parent_size {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": "50%",
            "height": "50%",
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": "50%",
                "height": "50%",
                "flex-shrink": 0,
                "_width": 0,
                "_height": 0
            }
        ],
        "_width": 0,
        "_height": 0
    }
    )");
}

- (void)test_percent_within_flex_grow {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 350,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "stretch",
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": "100%",
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 350,
        "height": 100,
        "flex-shrink": 0,
        "align-items": "stretch",
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "width": 100,
                "flex-shrink": 0,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": "100%",
                        "flex-shrink": 0,
                        "_width": 150,
                        "_height": 0
                    }
                ],
                "_x": 100,
                "_width": 150,
                "_height": 100
            },
            {
                "width": 100,
                "flex-shrink": 0,
                "_x": 250,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_percentage_container_in_wrapping_container {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": "100%",
                "flex-shrink": 0,
                "align-content": "start",
                "justify-content": "center",
                "direction": "horizontal"
              },
              "children": [
                {
                  "style": {
                    "background-color": "#1aff0000",
                    "width": 50,
                    "height": 50,
                    "flex-shrink": 0
                  }
                },
                {
                  "style": {
                    "background-color": "#1aff0000",
                    "width": 50,
                    "height": 50,
                    "flex-shrink": 0
                  }
                }
              ]
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 200,
        "height": 200,
        "flex-shrink": 0,
        "align-items": "center",
        "align-content": "start",
        "justify-content": "center",
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": "100%",
                        "flex-shrink": 0,
                        "align-content": "start",
                        "justify-content": "center",
                        "direction": "horizontal",
                        "children": [
                            {
                                "width": 50,
                                "height": 50,
                                "flex-shrink": 0
                            },
                            {
                                "width": 50,
                                "height": 50,
                                "flex-shrink": 0,
                                "_x": 50
                            }
                        ],
                        "_width": 100,
                        "_height": 50
                    }
                ],
                "_x": 50,
                "_y": 75,
                "_width": 100,
                "_height": 50
            }
        ]
    }
    )");
}

- (void)test_percent_absolute_position {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 60,
        "height": 50,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": "100%",
            "height": 50,
            "left": "50%",
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "horizontal"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": "100%",
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": "100%",
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    // TODO 'left' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 60,
//        "height": 50,
//        "flex-shrink": 0,
//        "align-content": "start",
//        "direction": "vertical",
//        "children": [
//            {
//                "width": "100%",
//                "height": 50,
//                "left": "50%",
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "horizontal",
//                "children": [
//                    {
//                        "width": "100%",
//                        "flex-shrink": 0,
//                        "_width": 60,
//                        "_height": 50
//                    },
//                    {
//                        "width": "100%",
//                        "flex-shrink": 0,
//                        "_x": 60,
//                        "_width": 60,
//                        "_height": 50
//                    }
//                ],
//                "_x": 30,
//                "_width": 60
//            }
//        ]
//    }
//    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGRoundingTest.html
@implementation YogaTests (YGRoundingTest)

- (void)test_rounding_flex_basis_flex_grow_row_width_of_100 {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 33,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 33,
                "_width": 34,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 67,
                "_width": 33,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_rounding_flex_basis_flex_grow_row_prime_number_width {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 113,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 113,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 23,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 23,
                "_width": 22,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 45,
                "_width": 23,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 68,
                "_width": 22,
                "_height": 100
            },
            {
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 90,
                "_width": 23,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_rounding_flex_basis_flex_shrink_row {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 101,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": 100,
            "flex-shrink": 1
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": 25,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-basis": 25,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 101,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "flex-basis": 100,
                "flex-shrink": 1,
                "_width": 51,
                "_height": 100
            },
            {
                "flex-basis": 25,
                "flex-shrink": 0,
                "_x": 51,
                "_width": 25,
                "_height": 100
            },
            {
                "flex-basis": 25,
                "flex-shrink": 0,
                "_x": 76,
                "_width": 25,
                "_height": 100
            }
        ]
    }
    )");
}

- (void)test_rounding_flex_basis_overrides_main_size {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 113,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 20,
            "flex-basis": 50,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 113,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 20,
                "flex-basis": 50,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 100,
                "_height": 64
            },
            {
                "height": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 64,
                "_width": 100,
                "_height": 25
            },
            {
                "height": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 89,
                "_width": 100,
                "_height": 24
            }
        ]
    }
    )");
}

- (void)test_rounding_total_fractial {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 87.4,
        "height": 113.4,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 20.3,
            "flex-basis": 50.3,
            "flex-grow": 0.7,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1.6,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10.7,
            "flex-grow": 1.1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 87.4,
        "height": 113.4,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 20.3,
                "flex-basis": 50.3,
                "flex-grow": 0.7,
                "flex-shrink": 0,
                "_width": 87,
                "_height": 59
            },
            {
                "height": 10,
                "flex-grow": 1.6,
                "flex-shrink": 0,
                "_y": 59,
                "_width": 87,
                "_height": 30
            },
            {
                "height": 10.7,
                "flex-grow": 1.1,
                "flex-shrink": 0,
                "_y": 89,
                "_width": 87,
                "_height": 24
            }
        ],
        "_width": 87,
        "_height": 113
    }
    )");
}

- (void)test_rounding_total_fractial_nested {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 87.4,
        "height": 113.4,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 20.3,
            "flex-basis": 50.3,
            "flex-grow": 0.7,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "height": 9.9,
                "flex-basis": 0.3,
                "bottom": 13.3,
                "flex-grow": 1,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "height": 1.1,
                "flex-basis": 0.3,
                "top": 13.3,
                "flex-grow": 4,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1.6,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10.7,
            "flex-grow": 1.1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    // TODO 'top', 'bottom' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 87.4,
//        "height": 113.4,
//        "flex-shrink": 0,
//        "align-content": "start",
//        "direction": "vertical",
//        "children": [
//            {
//                "height": 20.3,
//                "flex-basis": 50.3,
//                "flex-grow": 0.7,
//                "flex-shrink": 0,
//                "align-content": "start",
//                "direction": "vertical",
//                "children": [
//                    {
//                        "height": 9.9,
//                        "flex-basis": 0.3,
//                        "bottom": 13.3,
//                        "flex-grow": 1,
//                        "flex-shrink": 0,
//                        "_y": -13,
//                        "_width": 87,
//                        "_height": 12
//                    },
//                    {
//                        "height": 1.1,
//                        "flex-basis": 0.3,
//                        "top": 13.3,
//                        "flex-grow": 4,
//                        "flex-shrink": 0,
//                        "_y": 25,
//                        "_width": 87,
//                        "_height": 47
//                    }
//                ],
//                "_width": 87,
//                "_height": 59
//            },
//            {
//                "height": 10,
//                "flex-grow": 1.6,
//                "flex-shrink": 0,
//                "_y": 59,
//                "_width": 87,
//                "_height": 30
//            },
//            {
//                "height": 10.7,
//                "flex-grow": 1.1,
//                "flex-shrink": 0,
//                "_y": 89,
//                "_width": 87,
//                "_height": 24
//            }
//        ],
//        "_width": 87,
//        "_height": 113
//    }
//    )");
}

- (void)test_rounding_fractial_input_1 {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 113.4,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 20,
            "flex-basis": 50,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 113.4,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 20,
                "flex-basis": 50,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 100,
                "_height": 64
            },
            {
                "height": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 64,
                "_width": 100,
                "_height": 25
            },
            {
                "height": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 89,
                "_width": 100,
                "_height": 24
            }
        ],
        "_height": 113
    }
    )");
}

- (void)test_rounding_fractial_input_2 {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 113.6,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 20,
            "flex-basis": 50,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 113.6,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "height": 20,
                "flex-basis": 50,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 100,
                "_height": 65
            },
            {
                "height": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 65,
                "_width": 100,
                "_height": 24
            },
            {
                "height": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 89,
                "_width": 100,
                "_height": 25
            }
        ],
        "_height": 114
    }
    )");
}

- (void)test_rounding_fractial_input_3 {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 113.4,
        "top": 0.3,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 20,
            "flex-basis": 50,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    // TODO 'top' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 113.4,
//        "top": 0.3,
//        "flex-shrink": 0,
//        "align-content": "start",
//        "direction": "vertical",
//        "children": [
//            {
//                "height": 20,
//                "flex-basis": 50,
//                "flex-grow": 1,
//                "flex-shrink": 0,
//                "_width": 100,
//                "_height": 64
//            },
//            {
//                "height": 10,
//                "flex-grow": 1,
//                "flex-shrink": 0,
//                "_y": 64,
//                "_width": 100,
//                "_height": 25
//            },
//            {
//                "height": 10,
//                "flex-grow": 1,
//                "flex-shrink": 0,
//                "_y": 89,
//                "_width": 100,
//                "_height": 24
//            }
//        ],
//        "_height": 113
//    }
//    )");
}

- (void)test_rounding_fractial_input_4 {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 113.4,
        "top": 0.7,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 20,
            "flex-basis": 50,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    // TODO 'top' not supported
//XCTAssertLayout(@R"(
//    {
//        "width": 100,
//        "height": 113.4,
//        "top": 0.7,
//        "flex-shrink": 0,
//        "align-content": "start",
//        "direction": "vertical",
//        "children": [
//            {
//                "height": 20,
//                "flex-basis": 50,
//                "flex-grow": 1,
//                "flex-shrink": 0,
//                "_width": 100,
//                "_height": 64
//            },
//            {
//                "height": 10,
//                "flex-grow": 1,
//                "flex-shrink": 0,
//                "_y": 64,
//                "_width": 100,
//                "_height": 25
//            },
//            {
//                "height": 10,
//                "flex-grow": 1,
//                "flex-shrink": 0,
//                "_y": 89,
//                "_width": 100,
//                "_height": 24
//            }
//        ],
//        "_height": 113
//    }
//    )");
}

- (void)test_rounding_inner_node_controversy_horizontal {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 320,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "height": 10,
                "flex-grow": 1,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 320,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "height": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 107
            },
            {
                "height": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "height": 10,
                        "flex-grow": 1,
                        "flex-shrink": 0,
                        "_width": 106
                    }
                ],
                "_x": 107,
                "_width": 106
            },
            {
                "height": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 213,
                "_width": 107
            }
        ],
        "_height": 10
    }
    )");
}

- (void)test_rounding_inner_node_controversy_vertical {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "height": 320,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-grow": 1,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 10,
                "flex-grow": 1,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 10,
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "height": 320,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_height": 107
            },
            {
                "width": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": 10,
                        "flex-grow": 1,
                        "flex-shrink": 0,
                        "_height": 106
                    }
                ],
                "_y": 107,
                "_height": 106
            },
            {
                "width": 10,
                "flex-grow": 1,
                "flex-shrink": 0,
                "_y": 213,
                "_height": 107
            }
        ],
        "_width": 10
    }
    )");
}

- (void)test_rounding_inner_node_controversy_combined {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 640,
        "height": 320,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "height": "100%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": "100%",
            "flex-grow": 1,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": "100%",
                "flex-grow": 1,
                "flex-shrink": 0
              }
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": "100%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical"
              },
              "children": [
                {
                  "style": {
                    "background-color": "#1aff0000",
                    "width": "100%",
                    "flex-grow": 1,
                    "flex-shrink": 0
                  }
                }
              ]
            },
            {
              "style": {
                "background-color": "#1aff0000",
                "width": "100%",
                "flex-grow": 1,
                "flex-shrink": 0
              }
            }
          ]
        },
        {
          "style": {
            "background-color": "#1aff0000",
            "height": "100%",
            "flex-grow": 1,
            "flex-shrink": 0
          }
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 640,
        "height": 320,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "horizontal",
        "children": [
            {
                "height": "100%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_width": 213,
                "_height": 320
            },
            {
                "height": "100%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": "100%",
                        "flex-grow": 1,
                        "flex-shrink": 0,
                        "_width": 214,
                        "_height": 107
                    },
                    {
                        "width": "100%",
                        "flex-grow": 1,
                        "flex-shrink": 0,
                        "align-content": "start",
                        "direction": "vertical",
                        "children": [
                            {
                                "width": "100%",
                                "flex-grow": 1,
                                "flex-shrink": 0,
                                "_width": 214,
                                "_height": 106
                            }
                        ],
                        "_y": 107,
                        "_width": 214,
                        "_height": 106
                    },
                    {
                        "width": "100%",
                        "flex-grow": 1,
                        "flex-shrink": 0,
                        "_y": 213,
                        "_width": 214,
                        "_height": 107
                    }
                ],
                "_x": 213,
                "_width": 214,
                "_height": 320
            },
            {
                "height": "100%",
                "flex-grow": 1,
                "flex-shrink": 0,
                "_x": 427,
                "_width": 213,
                "_height": 320
            }
        ]
    }
    )");
}

@end

// https://github.com/facebook/yoga/blob/master/gentest/fixtures/YGSizeOverflowTest.html
@implementation YogaTests (YGSizeOverflowTest)

- (void)test_nested_overflowing_child {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 200,
                "height": 200,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": 200,
                        "height": 200,
                        "flex-shrink": 0
                    }
                ],
                "_width": 100,
                "_height": 200
            }
        ]
    }
    )");
}

- (void)test_nested_overflowing_child_in_constraint_parent {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "height": 100,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 200,
                "height": 200,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 100,
                "height": 100,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": 200,
                        "height": 200,
                        "flex-shrink": 0
                    }
                ]
            }
        ]
    }
    )");
}

- (void)test_parent_wrap_child_size_overflowing_parent {
    /*
    {
      "style": {
        "background-color": "#1aff0000",
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical"
      },
      "children": [
        {
          "style": {
            "background-color": "#1aff0000",
            "width": 100,
            "flex-shrink": 0,
            "align-content": "start",
            "direction": "vertical"
          },
          "children": [
            {
              "style": {
                "background-color": "#1aff0000",
                "width": 100,
                "height": 200,
                "flex-shrink": 0
              }
            }
          ]
        }
      ]
    }
    */
    XCTAssertLayout(@R"(
    {
        "width": 100,
        "height": 100,
        "flex-shrink": 0,
        "align-content": "start",
        "direction": "vertical",
        "children": [
            {
                "width": 100,
                "flex-shrink": 0,
                "align-content": "start",
                "direction": "vertical",
                "children": [
                    {
                        "width": 100,
                        "height": 200,
                        "flex-shrink": 0
                    }
                ],
                "_height": 200
            }
        ]
    }
    )");
}

@end
