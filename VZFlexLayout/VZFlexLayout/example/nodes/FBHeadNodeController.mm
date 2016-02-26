//
//  FBHeadNodeController.m
//  VZFlexLayout
//
//  Created by Sleen on 16/2/25.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBHeadNodeController.h"
#import "VZFNode.h"

@implementation FBHeadNodeController

- (void)didUpdateNode {
    [super didUpdateNode];
    NSLog(@"%@ did update", NSStringFromClass(self.node.class));
}

- (void)touchDown {
    NSLog(@"%@ touch down", NSStringFromClass(self.node.class));
}

@end
