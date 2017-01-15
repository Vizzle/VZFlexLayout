//
//  VZFCollectionView.m
//  O2OReact
//
//  Created by janeshi on 8/24/16.
//  Copyright © 2016 Alipay. All rights reserved.
//

#import "VZFCollectionView.h"
#import "VZFPagingView.h"

@implementation VZFCollectionView


- (BOOL)isAccessibilityElement{
    return NO;
}


- (NSInteger)accessibilityElementCount{
    return self.subviews.count;
};

//这两个方法是可以不复写的, 也能满足需求。实践并验证是以下两个方式有默认的内容
- (nullable id)accessibilityElementAtIndex:(NSInteger)index{
    return self.subviews[index];
};

- (NSInteger)indexOfAccessibilityElement:(id)element{
    return [self.subviews indexOfObject:element];
};


- (BOOL)accessibilityScroll:(UIAccessibilityScrollDirection)direction{
    
    BOOL isSupportedScroll = false;
    
    if (![self.superview isKindOfClass:[VZFPagingView class]]
        || ![self.superview respondsToSelector:@selector(scrollToPreviousItem)]
        || ![self.superview respondsToSelector:@selector(scrollToNextItem)]) {
        return false;
    }
    
    VZFPagingView* superView = (VZFPagingView*)self.superview;
    
    switch (direction) {
        case UIAccessibilityScrollDirectionRight:
            [superView scrollToPreviousItem];
            isSupportedScroll = true;
            break;
        case UIAccessibilityScrollDirectionLeft:
            [superView  scrollToNextItem];
            isSupportedScroll = true;
            break;
        default:
            break;
    }
    
    return isSupportedScroll;
}


@end
