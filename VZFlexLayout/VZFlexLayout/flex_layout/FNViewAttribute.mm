//
//  FNViewAttribute.m
//  FNode
//
//  Created by Sleen on 15/12/18.
//  Copyright © 2015年 O2O. All rights reserved.
//

#include "FNViewAttribute.h"

@interface BlockWrapper : NSObject
@property (nonatomic, copy) void (^block)(id sender);
- (void) invoke:(id)sender;
@end

@implementation BlockWrapper
- (void) dealloc {
    self.block = nil;
}

- (void) invoke:(id)sender {
    self.block(sender);
}
@end

namespace flex {
    
    FNViewAttributeMap::value_type GestrueAttribute(Class cls, void(^block)(id sender)) {
        std::string identifier = std::string(class_getName(cls));
        return {
            FNViewAttribute{
                identifier,
                ^(id view, id value) {
                    NSMutableArray * blockArray = objc_getAssociatedObject(view, "blockArray");
                    
                    if (blockArray == nil) {
                        blockArray = [NSMutableArray array];
                        objc_setAssociatedObject(view, "blockArray", blockArray, OBJC_ASSOCIATION_RETAIN);
                    }
                    
                    BlockWrapper *blockWrapper = [[BlockWrapper alloc] init];
                    blockWrapper.block = block;
                    [blockArray addObject:blockWrapper];
                    
                    OSGestureRecognizer *recognizer = [[cls alloc] init];
#if FLEX_IOS
                    [recognizer addTarget:blockWrapper action:@selector(invoke:)];
#elif FLEX_OSX
                    recognizer.action = @selector(invoke:);
                    recognizer.target = blockWrapper;
#endif
                    [view addGestureRecognizer:recognizer];
                }
            },
            @YES
        };
    }
    
}
