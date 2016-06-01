//
//  VZFButtonView.h
//  O2OReact
//
//  Created by moxin on 16/5/30.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeBackingViewInterface.h"

@interface VZFButtonView : UIButton<VZFNodeBackingViewInterface>

@property(nonatomic,assign) CGSize enlargeTouchSize;

@end
