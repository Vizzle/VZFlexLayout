//
//  FBViewController.m
//  DynamicView
//
//  Created by moxin on 16/3/21.
//  Copyright © 2016年 John Wong. All rights reserved.
//

#import "FBViewController.h"
#import "VZFNodeHostingView.h"
#import "FBSampleNode.h"
#import "FBSampleStore.h"
#import "FBHostItem.h"
#import "VZFlux.h"

@interface FBViewController ()<VZFNodeHostingView,VZFNodeProvider>
{
    VZFNodeHostingView* _hostingView;
    FBSampleStore* _store;
}

@end


@implementation FBViewController

- (void)dealloc{
    NSLog(@"[%@]-->dealloc",self.class);
}



- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(reloadData)];
    
    NSString* path1 = [[NSBundle mainBundle] pathForResource:@"scroll" ofType:@"json"];
    NSData* data1 = [NSData dataWithContentsOfFile:path1];
    NSDictionary* json1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONWritingPrettyPrinted error:nil];
    FBHostItem* item1 = [FBHostItem newWithJSON:json1];
    
    _store = [[FBSampleStore alloc]initWithDispatcher:[VZFluxDispatcher new]];
    _hostingView = [[VZFNodeHostingView alloc]initWithNodeProvider:[self class] RangeType:VZFlexibleSizeHeight];
    _hostingView.backgroundColor = [UIColor whiteColor];
    _hostingView.shouldResize = YES;
    _hostingView.delegate = self;
    _hostingView.store = _store;
    _hostingView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0);
    [_hostingView update:item1 context:nil];

    [_hostingView.store addListener:^(NSString *eventType, id data) {
       
        NSLog(@"eventType:%@",eventType);
        
    }];
    [self.view addSubview:_hostingView];
    

}

- (void)reloadData
{
    NSString* path1 = [[NSBundle mainBundle] pathForResource:@"scroll" ofType:@"json"];
    NSData* data1 = [NSData dataWithContentsOfFile:path1];
    NSDictionary* json1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONWritingPrettyPrinted error:nil];
    FBHostItem* item1 = [FBHostItem newWithJSON:json1];
    [_hostingView reset];
    [_hostingView update:item1 context:nil];
}
//
//- (void)reloadData{
//
//    NSString* path2 = [[NSBundle mainBundle] pathForResource:@"result2" ofType:@"json"];
//    NSData* data2 = [NSData dataWithContentsOfFile:path2];
//    NSDictionary* json2 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONWritingPrettyPrinted error:nil];
//    FBHostItem* item2 = [FBHostItem newWithJSON:json2];
//    [self.bottomView update:item2 context:nil];
//
//}

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(id)store Context:(id)context{
    
    if (!item) {
        return nil;
    }
    return [FBSampleNode newWithProps:item Store:store Context:context];
}


- (void)hostingViewDidInvalidate:(CGSize)sz{

    NSLog(@"%s",__PRETTY_FUNCTION__);

}



@end
