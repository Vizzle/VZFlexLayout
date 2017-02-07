//
//  VZFButtonNodeBackingView.h
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFBackingViewProtocol.h"

@interface VZFButtonNodeBackingView : UIButton<VZFBackingViewProtocol>

-(void)setTitleFont:(UIFont *)font;

-(void)setButtonStatus:(UIControlState)state;

@end
