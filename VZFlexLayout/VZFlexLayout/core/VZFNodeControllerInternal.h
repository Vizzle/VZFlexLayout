//
//  VZFNodeControllerInternal.h
//  VZFlexLayout
//
//  Created by Sleen on 16/2/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeController.h"

@class VZFNode;
@interface VZFNodeController ()

- (void)nodeWillMount:(VZFNode *)node;
- (void)nodeDidMount:(VZFNode *)node;
- (void)node:(VZFNode* )node willReleaseBackingView:(UIView* )view;
- (void)node:(VZFNode* )node didAquireBackingView:(UIView* )view;
- (void)nodeWillUnmount:(VZFNode *)node;
- (void)nodeDidUnmount:(VZFNode *)node;

@end
