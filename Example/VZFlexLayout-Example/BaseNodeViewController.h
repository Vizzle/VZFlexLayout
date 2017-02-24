//
//  BaseNodeViewController.h
//  VZFlexLayout-Example
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VZFlexLayout/VZFlexLayout.h>

@interface BaseNodeViewController : UIViewController

@property (nonatomic, strong) VZFNodeHostingView *hostingView;
@property (nonatomic, copy) NSMutableDictionary *state;
@property (nonatomic, strong) UILabel *infoLabel;

- (NSDictionary *)initialState;

- (void)update;

@end
