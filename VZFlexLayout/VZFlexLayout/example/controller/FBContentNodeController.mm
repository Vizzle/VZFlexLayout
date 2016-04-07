//
//  FBContentNodeController.m
//  VZFlexLayout
//
//  Created by Sleen on 16/2/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBContentNodeController.h"
#import "FBContentNode.h"

@interface FBContentNodeController () <UIAlertViewDelegate>

@end


@implementation FBContentNodeController
{
    UIAlertView *_alertView;
}

- (id)init{
    self = [super init];
    if (self) {
        
        NSLog(@"a");
    }
    return self;
}


- (void)didUpdateNode {
    
    NSLog(@"%@",self);
    
    
}

- (void)dealloc{
    
    NSLog(@"[%@]-->dealloc",self.class);
}

@end
