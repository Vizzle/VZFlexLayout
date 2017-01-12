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
#import "FBHeaderNode.h"
#import "VZFlux.h"
#import "VZFTextNode.h"
#import <libkern/OSAtomic.h>


@interface FBViewController ()<VZFNodeHostingView,VZFNodeProvider>
{
    NSMutableArray* _list;
    VZFNodeHostingView* _hostingView;
    FBSampleStore* _store;
    OSSpinLock _lock;
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString* path1 = [[NSBundle mainBundle] pathForResource:@"result" ofType:@"json"];
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


+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(id)store Context:(id)context{
    
    if (!item) {
        return nil;
    }
    //return [FBHeaderNode newWithProps:item Store:store Context:context];
    return [FBSampleNode newWithProps:item Store:store Context:context];
}


- (void)hostingViewDidInvalidate:(CGSize)sz{

    NSLog(@"%s",__PRETTY_FUNCTION__);

}

@end
