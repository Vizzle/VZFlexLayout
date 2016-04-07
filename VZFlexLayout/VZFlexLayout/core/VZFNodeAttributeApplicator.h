//
//  VZFNodeAttributeApplicator.h
//  O2OReact
//
//  Created by moxin on 16/4/1.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VZFNode;
@interface VZFNodeAttributeApplicator : NSObject

+ (void)applyNodeAttributes:(VZFNode* )node toView:(UIView* )view;

@end
