//
//  VZFButtonView.h
//  O2OReact
//
//  Created by moxin on 16/5/30.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeBackingViewInterface.h"
#import "VZFButtonNodeBackingView.h"

@interface VZFButtonView : VZFButtonNodeBackingView<VZFNodeBackingViewInterface>

@property(nonatomic,assign) CGSize enlargeTouchSize;

@end
