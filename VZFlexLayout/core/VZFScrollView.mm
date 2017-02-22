//
//  VZFScrollView.m
//  O2OReact
//
//  Created by moxin on 16/5/13.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFScrollView.h"
#import "UIView+VZAttributes.h"
#import "VZFScrollNode.h"

@implementation VZFScrollView


/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - backing view interface

- (void)born{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}

- (void)dead{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}

- (void)prepareForReuse{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}

- (void)willEnterReusePool{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}

- (void)didLeaveReusePool{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
}


- (void)resetState{
    self.contentOffset = CGPointZero;
}

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    VZFScrollNode *scrollNode = (VZFScrollNode *)node;
    ScrollNodeSpecs specs = scrollNode.scrollNodeSpecs;
    self.scrollEnabled = specs.scrollEnabled;
    self.pagingEnabled = specs.paging;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.scrollsToTop = NO;
    self.contentSize = scrollNode.contentSize;
    [self setNeedsLayout];
}

@end
