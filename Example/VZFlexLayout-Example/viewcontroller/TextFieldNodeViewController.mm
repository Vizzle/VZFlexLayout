//
//  TextFieldNodeViewController.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/1/4.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "TextFieldNodeViewController.h"
#import <VZFlexLayout/VZFlexLayout.h>

@interface SearchNode : VZFCompositeNode <VZFNodeRequiredMethods>

@end

@implementation SearchNode

+ (instancetype)newWithProps:(id)props Store:(VZFluxStore *)store Context:(id)ctx {
    VZFStackNode *node = [VZFStackNode newWithStackAttributes:{
        .direction = VZFlexHorizontal,
        .alignItems = VZFlexStretch,
    } NodeSpecs:{
        .padding = 5,
    } Children:{
        {
            [VZFTextFieldNode newWithTextFieldAttributes:{
                .text = props,
                .placeholder = @"Input a keyword",
                .font = [UIFont systemFontOfSize:14.0f],
                .color = [UIColor colorWithWhite:51.0/255.0 alpha:1.0],
                .clearButtonMode = UITextFieldViewModeWhileEditing,
                .eventHandler = [[VZFTextFieldEventHandler alloc] initWithHandler:^(UITextField * _Nonnull textField, VZFTextFieldEventType type) {
                    NSLog(@"=== Receive event: [%ld], text: [%@]", (long)type, textField.text);
                }]
            } NodeSpecs:{
                .flexGrow = 1,
                .backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0],
                .marginRight = 5,
                .padding = 5,
                .cornerRadius = 4,
            }]
        },
        {
            [VZFButtonNode newWithButtonAttributes:{
                .title = @"Go",
                .titleColor = {[UIColor whiteColor]},
            } NodeSpecs:{
                .width = 50,
                .backgroundColor = [UIColor colorWithRed:251.0/255 green:97.0/255 blue:101.0/255 alpha:1.0],
                .cornerRadius = 4
            }]
        }
    }];
    
    return [super newWithNode:node];
}

@end

@interface TextFieldNodeViewController () <VZFNodeProvider>

@property (nonatomic, strong) VZFNodeHostingView *searchView;

@end

@implementation TextFieldNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"VZFTextFieldNode";
    
    self.searchView = [[VZFNodeHostingView alloc] initWithNodeProvider:[self class] RangeType:VZFlexibleSizeNone];
    self.searchView.frame = CGRectMake(0, 64, self.view.frame.size.width, 40);
    [self.searchView update:@"Hello React" context:self];
    [self.view addSubview:self.searchView];
}

#pragma mark - VZFNodeProvider

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx {
    return [SearchNode newWithProps:item Store:store Context:ctx];
}

@end
