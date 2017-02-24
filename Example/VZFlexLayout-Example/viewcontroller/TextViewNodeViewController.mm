//
//  TextViewNodeViewController.m
//  VZFlexLayout-Example
//
//  Created by wuwen on 2017/2/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "TextViewNodeViewController.h"
#import <VZFlexLayout/VZFlexLayout.h>

@interface TextViewNode : VZFCompositeNode <VZFNodeRequiredMethods>

@end

@implementation TextViewNode

+ (instancetype)newWithProps:(id)props Store:(VZFluxStore *)store Context:(id)ctx {
    VZFStackNode *node = [VZFStackNode newWithStackAttributes:{
    } NodeSpecs:{
        .padding = 10,
    } Children:{
        {
            [VZFTextViewNode newWithTextViewAttributes:{
                .text = @"",
                .font = [UIFont systemFontOfSize:20.0f],
                .color = [UIColor redColor],
                .placeholder = @"Walalalalala ...",
                .returnKeyType = UIReturnKeyDone
            } NodeSpecs:{
                .backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0],
                .cornerRadius = 4,
                .clip = YES,
                .flexGrow = 1,
                .paddingTop = 5,
                .paddingBottom = 5,
            }]
        }
    }];
    
    return [super newWithNode:node];
}

@end

@interface TextViewNodeViewController ()

@end

@implementation TextViewNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"VZFTextViewNode";
    
    self.hostingView = [[VZFNodeHostingView alloc] initWithNodeProvider:[self class] RangeType:VZFlexibleSizeNone];
    self.hostingView.frame = CGRectMake(0, 64, self.view.frame.size.width, 200);
    [self.hostingView update:self.state context:self];
    [self.view addSubview:self.hostingView];
}

#pragma mark - VZFNodeProvider

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx {
    return [TextViewNode newWithProps:item Store:store Context:ctx];
}

@end
