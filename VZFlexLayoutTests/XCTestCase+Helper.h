//
//  XCTestCase+Helper.h
//  VZFlexLayout
//
//  Created by Sleen on 2017/8/8.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#ifdef __cplusplus

#import <XCTest/XCTest.h>
#import "FlexLayout.h"

// uncomment the below line to run tests with yoga
//#define YOGA 1

#define XCTAssertLayout(layout)                     \
do {                                                \
    NSString *error = [self checkLayout:layout];    \
    XCTAssertNil(error);                            \
} while (0)

#define XCTAssertLayoutWithConfig(w, h, s, layout)  \
do {                                                \
    NSString *error = [self checkLayout:layout withWidth:w height:h scale:s];    \
    XCTAssertNil(error);                            \
} while (0)

@interface XCTestCase (Helper)

- (NSString *)checkLayout:(NSString *)layoutWithResult;
- (NSString *)checkLayout:(NSString *)layoutWithResult withWidth:(float)width height:(float)height scale:(float)scale;

@end

#endif
