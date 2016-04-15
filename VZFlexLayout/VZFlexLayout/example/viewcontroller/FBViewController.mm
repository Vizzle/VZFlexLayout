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
#import "FBClickToExpendNode.h"
#import "VZFNodeSpecs.h"

@interface FBViewController ()<VZFNodeHostingView,VZFNodeProvider>
@property(nonatomic,strong)VZFNodeHostingView* hostingViewHeader;
@property(nonatomic,strong)VZFNodeHostingView* hostingViewBody;
@property(nonatomic,strong)VZFNodeHostingView* hostingViewFooter;

@end


@implementation FBViewController

- (void)dealloc{
    NSLog(@"[%@]-->dealloc",self.class);
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.hostingViewHeader = [[VZFNodeHostingView alloc]initWithNodeProvider:self
                                                         RangeProvider:[VZSizeRangeProvider defaultRangeProvider:VZFlexibleSizeHeight]];
    
    
    self.hostingViewHeader.backgroundColor = [UIColor whiteColor];
    self.hostingViewHeader.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0);
//    self.hostingViewHeader.frame = {{0,0},{CGRectGetWidth(self.view.bounds),VZFlexValueAuto}};
    self.hostingViewHeader.delegate = self;
    
    
//    self.hostingViewHeader = [[VZFNodeHostingView alloc]initWithNodeProvider:self
//                                                               RangeProvider:[VZSizeRangeProvider defaultRangeProvider:VZFlexibleSizeHeight]];
//    
//    
//    self.hostingViewHeader.backgroundColor = [UIColor whiteColor];
//    self.hostingViewHeader.frame = {{0,0},{CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds)-64}};
//    self.hostingViewHeader.delegate = self;
//    
//    self.hostingViewHeader = [[VZFNodeHostingView alloc]initWithNodeProvider:self
//                                                               RangeProvider:[VZSizeRangeProvider defaultRangeProvider:VZFlexibleSizeHeight]];
//    
//    
//    self.hostingViewHeader.backgroundColor = [UIColor whiteColor];
//    self.hostingViewHeader.frame = {{0,0},{CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds)-64}};
//    self.hostingViewHeader.delegate = self;


    
    [self.view addSubview:self.hostingViewHeader];
    
    
    [self loadData];
}

- (void)loadData
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"result1" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
    FBHostItem* item = [FBHostItem newWithJSON:json];
    [self.hostingViewHeader update:item mode:VZFUpdateModeSynchronous];
    
}

- (VZFNode *)nodeForItem:(FBHostItem* )item context:(id<NSObject>)context{
    
    //    FBHeaderNode* node = [FBHeaderNode newWithItem:item];
    //    FBContentNode* node = [FBContentNode newWithItem:item];
    //    FBHostNode* node = [FBHostNode newWithItem:item];
    
    FBClickToExpendNode* node = [FBClickToExpendNode newWithItem:item];
    return node;
}




- (void)hostingView:(VZFNodeHostingView *)view DidInvalidate:(CGSize)newSize
{
    if (view.tag == 0) {
        
    }
}


@end
