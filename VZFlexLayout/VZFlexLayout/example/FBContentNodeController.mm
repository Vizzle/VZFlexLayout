//
//  FBContentNodeController.m
//  VZFlexLayout
//
//  Created by Sleen on 16/2/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBContentNodeController.h"
#import "FBContentNode.h"
#import "VZFNodeInternal.h"

@interface FBContentNodeController () <UIAlertViewDelegate>

@end

@implementation FBContentNodeController
{
    UIAlertView *_alertView;
}

- (void)didTap:(id)sender {
    NSLog(@"%@ didTap", NSStringFromClass([sender class]));
    
    if (((FBContentNode*)self.node).expanded) {
        [self update];
    }
    else {
        _alertView = [[UIAlertView alloc] initWithTitle:@"确定要展开吗？"
                                                message:nil
                                               delegate:self
                                      cancelButtonTitle:@"取消" 
                                      otherButtonTitles:@"确定", nil];
        [_alertView show];
    }
}

- (void)alertView:(UIAlertView *)alert didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) return;
    [self update];
}

- (void)update {
    [self.node updateState:^id(NSNumber* oldState) {
        
        id state =  @(![oldState boolValue]);
        return state;
        
    }];
}

@end
