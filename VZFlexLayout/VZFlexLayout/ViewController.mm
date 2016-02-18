//
//  ViewController.m
//  VZFlexLayout
//
//  Created by moxin on 15/12/25.
//  Copyright © 2015年 Vizlab. All rights reserved.
//

#import "ViewController.h"
#import "VZFNode.h"
#import "VZFStackNode.h"
#import "VZFNodeHostingView.h"
#import "VZFButtonNode.h"
#import "VZFCompositeNode.h"

@interface ViewController ()<VZFNodeHostingView>

@property(nonatomic,strong)VZFNodeHostingView* hostingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.hostingView = [[VZFNodeHostingView alloc]initWithNodeProvider:[self class]
                                                         RangeProvider:[VZSizeRangeProvider defaultRangeProvider:VZFlexibleSizeHeight]];
    self.hostingView.backgroundColor = [UIColor orangeColor];
    self.hostingView.frame = {{0,0},{CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds)}};
    self.hostingView.delegate = self;
    [self.view addSubview:self.hostingView];
    
    [self.hostingView renderWithState:nil];
    
}


+ (VZFNode *)nodeForItem:(id<NSObject>)item context:(id<NSObject>)context{

    
    VZFCompositeNode* compositeNode = [VZFCompositeNode newWithNode:[self stackNodes] Props:nil];
    return compositeNode;
    
    
//    return [self simpleNode];
//    return [self stackNodes];
}

+ (VZFlexNode* )textNode{

//    VZ::TextKitAttributes attr = {
//    
//        .attributedString = [[NSAttributedString alloc]initWithString:@"a"],
//    
//    };
    

    return nil;

}

+ (VZFNode* )simpleNode{

    
    VZFButtonNode* buttonNode = [VZFButtonNode newWithNodeSpecs:{
        
        .view = {
            .userInteractionEnabled = YES,
            .backgroundColor = [UIColor redColor],
            .layer = {
                .cornerRadius = 50,
            },
            .block = ^(UIView *view) {
                view.layer.borderWidth = 1;
                view.layer.borderColor = [UIColor whiteColor].CGColor;
            }
        },
        .flex = {
            .width = 100,
            .height = 100,
            .margin = 100
        }
    
    
    } ButtonAttributes:{
    
        .title = @"按钮",
        .titleFont = [UIFont systemFontOfSize:14.0f],
        .titleColor = [UIColor yellowColor],
        .action = ^(UIButton* btn){
        
        
        }
    
    }];
    
//    VZFNode* node = [VZFNode newWithView:[UIView class] NodeSpecs:{
//    
//        .view = {
//            .userInteractionEnabled = YES,
//            .backgroundColor = [UIColor redColor],
//            .layer = {
//                .cornerRadius = 50,
//            },
//            .block = ^(UIView *view) {
//                view.layer.borderWidth = 1;
//                view.layer.borderColor = [UIColor whiteColor].CGColor;
//            }
//        },
//        .flex = {
//            .width = 100,
//            .height = 100,
//            .margin = 100
//        },
//        .gestures = {
//            
//            GestureBuilder<UITapGestureRecognizer>(^(id sender) {
//                
//                NSLog(@"tapped!!");
//                
//            }),
//        }
//        
//    }];
    
    
    return buttonNode;
    
    
//    VZFStackNode* stackNdoe =[VZFStackNode nodeWithStackSpecs:{
//        
//        .flex= {
//            .width = 200,
//            .height = 200
//        }
//        
//        
//    } Children:{
//        {.node = node}
//    }];
//
//    NSLog(@"%@", stackNdoe);
//  
//    return stackNdoe;

}


+ (VZFStackNode* )stackNodes{

    VZFNode* imageNode = [VZFNode newWithView:[UIView class] NodeSpecs:{
        
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
        }];
    
    VZFNode* textNode = [VZFNode newWithView:[UIView class] NodeSpecs:{
    
            .view = {
                .tag = 101,
                .backgroundColor = [UIColor yellowColor]
            },
            .flex={
                .marginTop = 10,
                .marginLeft = 10,
                .marginRight = 10,
                .height = 100,
                .flexGrow = 1
            }
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

    VZFNode* contentNode = [VZFNode newWithView:[UIView class] NodeSpecs:{
            .view = {
                .backgroundColor = [UIColor greenColor],
            },
            .flex = {
                .marginLeft = 120,
                .marginTop = 10,
                .marginRight = 10,
                .height = 150,
                .width = 200
            }
        }];
    

    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
        
        .view = {
            .backgroundColor = [UIColor whiteColor],
        },
        .flex = {
            .stackLayout = {
                .direction = VZFlexVertical
            }
        }
    
    } Children:{
        {.node = stackNodeTopNode},
        {.node = contentNode}
    
    }];
    
  
    return stackNode;

}


- (void)hostingViewDidInvalidate:(CGSize)newSize{
//    self.hostingView.frame = {self.hostingView.frame.origin, newSize};
}

@end

