//
//  DemoCell.m
//  VZFlexLayout
//
//  Created by 俞伟平 on 2/23/16.
//  Copyright © 2016 Vizlab. All rights reserved.
//

#import "DemoCell.h"
#import "VZFNodeHostingView.h"
#import "VZFCompositeNode.h"
#import "VZFButtonNode.h"
#import "VZFTextNode.h"
#import "VZFImageNode.h"
#import "VZFStackNode.h"
#import "VZFNodeViewManager.h"

@interface DemoCell()<VZFNodeHostingView>

@property(nonatomic,strong)VZFNodeHostingView* hostingView;

@end


@implementation DemoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.hostingView = [[VZFNodeHostingView alloc]initWithNodeProvider:[self class]
                                                             RangeProvider:[VZSizeRangeProvider defaultRangeProvider:VZFlexibleSizeWidthAndHeight]];
        self.hostingView.backgroundColor = [UIColor orangeColor];
        self.hostingView.frame = {{0,0},{CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds)}};
        self.hostingView.delegate = self;
        [self.contentView addSubview:self.hostingView];
        
        [self.hostingView renderWithState:nil reuseView:self];

    }
    
    return self;
}

//Vizzle setItem
- (void)updateNode {
    [self.hostingView renderWithState:nil reuseView:self];
}


+ (VZFNode *)nodeForItem:(id<NSObject>)item context:(id<NSObject>)context{
    
    VZFNode* node = [self stackNodes];
    
    objc_setAssociatedObject(self, &kViewReuseInfoKey, node, OBJC_ASSOCIATION_ASSIGN);
    
    return node;
}




+ (VZFStackNode* )stackNodes{
    
    VZFNode* imageNode = [VZFImageNode newWithNodeSpecs:{
        .view = {
            
            .tag = 100,
            .backgroundColor = [UIColor redColor],
            .clipToBounds = YES,
            .layer = {
                
                .cornerRadius = 10,
                .borderColor = [UIColor whiteColor]
            }
        },
        .flex = {
            
            .marginTop = 10,
            .marginLeft = 10,
            .width = 100,
            .height = 100,
        }
    } ImageAttributes:{
        .image = [UIImage imageNamed:@"cat"],
        .contentMode = UIViewContentModeScaleAspectFill
    }];
    
    VZFTextNode *textNode = [VZFTextNode newWithNodeSpecs:{
        
        .view = {
            .tag = 101,
            .backgroundColor = [UIColor yellowColor]
        },
        .flex={
            .marginTop = 10,
            .marginLeft = 10,
            .marginRight = 10,
            .alignSelf = VZFlexCenter,
        }
    } TextAttributes:{
        .text = @"ABC123",
        .color = [UIColor blueColor],
    }];
    
    VZFStackNode* stackNodeTopNode = [VZFStackNode newWithStackSpecs:{
        
        .name = "TopNode",
        .view = {
            .tag = 10,
            .backgroundColor = [UIColor cyanColor]
        },
        .flex = {
            .stackLayout = {
                .direction = VZFlexHorizontal,
            }
        }
        
    } Children:{
        
        
        {.node = imageNode},
        {.node = textNode},
        
    }];
    
    
    
    
    
    return stackNodeTopNode;
    
}

@end
