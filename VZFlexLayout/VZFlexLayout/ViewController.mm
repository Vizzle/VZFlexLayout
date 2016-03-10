//
//  ViewController.m
//  VZFlexLayout
//
//  Created by moxin on 15/12/25.
//  Copyright © 2015年 Vizlab. All rights reserved.
//

#import "ViewController.h"
#import "VZFNodeHostingView.h"
#import "TableViewController.h"
#import "FBHostNode.h"
#import "FBHostItem.h"

@interface ViewController ()<VZFNodeHostingView>


- (void)imageDidTap;
- (void)onLikeClicked:(id)sender;

@property(nonatomic,strong)VZFNodeHostingView* hostingView;


@end

@implementation ViewController

- (void)imageDidTap {
    NSLog(@"imageDidTap");
}
- (void)onLikeClicked:(id)sender{
    NSLog(@"liked!");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.hostingView = [[VZFNodeHostingView alloc]initWithNodeProvider:[self class]
                                                         RangeProvider:[VZSizeRangeProvider defaultRangeProvider:VZFlexibleSizeHeight]];
    self.hostingView.backgroundColor = [UIColor whiteColor];
    self.hostingView.frame = {{0,0},{CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds)}};
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
    [self.hostingView render:item];
}

- (void)goTable {
    [self.navigationController pushViewController:[TableViewController new] animated:YES];
}


+ (VZFNode *)nodeForItem:(FBHostItem* )item context:(id<NSObject>)context{

    FBHostNode* node = [FBHostNode newWithItem:item];
    return node;
}



- (void)hostingViewDidInvalidate:(CGSize)newSize{
//    self.hostingView.frame = {self.hostingView.frame.origin, newSize};
}

@end

