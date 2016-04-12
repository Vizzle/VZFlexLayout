//
//  FBViewController.m
//  DynamicView
//
//  Created by moxin on 16/3/21.
//  Copyright © 2016年 John Wong. All rights reserved.
//

#import "FBViewController.h"
#import "VZFNodeHostingView.h"
#import "FBHostNode.h"
#import "FBHostItem.h"
#import "VZFStackNode.h"
#import "VZFTextNode.h"
#import "VZFImageNode.h"
#import "FBHeaderNode.h"
#import "FBContentNode.h"

@interface FBViewController ()<VZFNodeHostingView>
@property(nonatomic,strong)VZFNodeHostingView* hostingView;

@end


@implementation FBViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.hostingView = [[VZFNodeHostingView alloc]initWithNodeProvider:[self class]
                                                         RangeProvider:[VZSizeRangeProvider defaultRangeProvider:VZFlexibleSizeHeight]];
    self.hostingView.backgroundColor = [UIColor whiteColor];
    self.hostingView.frame = {{0,0},{CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds)-64}};
    self.hostingView.delegate = self;
    [self.view addSubview:self.hostingView];
    
    
    [self loadData];
}

- (void)loadData
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"result1" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
    FBHostItem* item = [FBHostItem newWithJSON:json];
    [self.hostingView update:item mode:VZFUpdateModeSynchronous];
}

+ (VZFNode *)nodeForItem:(FBHostItem* )item context:(id<NSObject>)context{
    
    FBHeaderNode* node = [FBHeaderNode newWithItem:item];
//    FBContentNode* node = [FBContentNode newWithItem:item];
//    FBHostNode* node = [FBHostNode newWithItem:item];
    return node;
}



- (void)hostingViewDidInvalidate:(CGSize)newSize{
    //    self.hostingView.frame = {self.hostingView.frame.origin, newSize};
}

@end
