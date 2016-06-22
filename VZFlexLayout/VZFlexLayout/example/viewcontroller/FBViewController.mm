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
#import "FBScrollNode.h"
#import "FBIconNode.h"

@interface FBViewController ()<VZFNodeHostingView,VZFNodeProvider>
{
}

@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic,strong)VZFNodeHostingView* topView;
@property(nonatomic,strong)VZFNodeHostingView* bottomView;

@end


@implementation FBViewController

- (void)dealloc{
    NSLog(@"[%@]-->dealloc",self.class);
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(reloadData)];
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.bounces = YES;
    [self.view addSubview:self.scrollView];
    
    
    self.topView = [[VZFNodeHostingView alloc]initWithNodeProvider:self
                                                         RangeProvider:[VZSizeRangeProvider defaultRangeProvider:VZFlexibleSizeHeight]];
    

    self.topView.backgroundColor = [UIColor whiteColor];
    self.topView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 1);
    self.topView.delegate = self;
    [self.scrollView addSubview:self.topView];
    
    
    
    
    self.bottomView = [[VZFNodeHostingView alloc]initWithNodeProvider:self RangeProvider:[VZSizeRangeProvider defaultRangeProvider:VZFlexibleSizeHeight]];
    self.bottomView.tag = 1;
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 1);
    self.bottomView.delegate = self;
    [self.scrollView addSubview:self.bottomView];
    
    //fake network requeset
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
    });
 
}

- (void)loadData
{
    NSString* path1 = [[NSBundle mainBundle] pathForResource:@"result1" ofType:@"json"];
    NSData* data1 = [NSData dataWithContentsOfFile:path1];
    NSDictionary* json1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONWritingPrettyPrinted error:nil];
    FBHostItem* item1 = [FBHostItem newWithJSON:json1];
    
   [self.topView update:item1 mode:VZFStateUpdateModeAsynchronous];

}

- (void)reloadData{

    NSString* path2 = [[NSBundle mainBundle] pathForResource:@"result2" ofType:@"json"];
    NSData* data2 = [NSData dataWithContentsOfFile:path2];
    NSDictionary* json2 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONWritingPrettyPrinted error:nil];
    FBHostItem* item2 = [FBHostItem newWithJSON:json2];
    
    [self.bottomView update:item2 mode:VZFStateUpdateModeAsynchronous];

}

- (VZFNode *)nodeForItem:(FBHostItem* )item context:(id<NSObject>)context{

    if (!item) {
        return nil;
    }
    
    return [FBIconNode newWithURL:@"http://www.collegedj.net/wp-content/uploads/2016/04/collegedj-sound-check-mixtape-volume-13-130x50.jpg"];
    
//    return [FBHostNode newWithItem:item];
//    NSNumber* tag = (NSNumber* )context;
//    if ([tag integerValue] == 0) {
//        //return [FBScrollNode newWithItem:item];
//           return [FBHostNode newWithItem:item];
//    }
//    else{
//        return [FBClickToExpendNode newWithItem:item];
//    }
}

- (void)hostingView:(VZFNodeHostingView *)view DidInvalidate:(CGSize)newSize
{
    NSLog(@"%s=>Size:%@",__PRETTY_FUNCTION__,NSStringFromCGSize(newSize));
    if (view.tag == 0) {
        view.frame = CGRect{{0,0},newSize};
        self.bottomView.frame = CGRect{{0,view.frame.size.height},self.bottomView.frame.size};
    }
    else{
        view.frame = CGRect{{0,self.topView.frame.size.height},newSize};
    }
    
    
    CGFloat h = MAX( CGRectGetHeight(self.topView.bounds) + CGRectGetHeight(self.bottomView.bounds) + 64, CGRectGetHeight(self.view.bounds) + 64);
    
    self.scrollView.contentSize = {CGRectGetWidth(self.view.bounds),h};

//    self.bottomView.frame = CGRect{{0,self.topView.frame.size.height},view.tag==1?view.frame.size:CGSizeZero};
    
}


@end
