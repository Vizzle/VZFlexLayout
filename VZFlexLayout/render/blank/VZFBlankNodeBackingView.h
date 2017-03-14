//
//  VZFBlankNodeBackingView.h
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/22.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeBackingViewInterface.h"
#import "VZFBlankNodeRenderer.h"
#import "VZFBackingViewProtocol.h"

@interface VZFBlankNodeBackingView : UIView<VZFNodeBackingViewInterface, VZFBackingViewProtocol>

@property(nonatomic,strong) UIColor* defaultColor;
@property(nonatomic,strong) UIColor* highlightColor;
@property(nonatomic,strong) VZFBlankNodeRenderer* blankRenderer;

@end
