//
//  VZFScrollView.m
//  O2OReact
//
//  Created by moxin on 16/5/13.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFScrollView.h"

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
    
    NSLog(@"%s",__PRETTY_FUNCTION__);
    self.contentOffset = CGPointZero;
}

@end
