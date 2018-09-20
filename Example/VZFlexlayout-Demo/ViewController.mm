//
//  ViewController.m
//  VZFlexlayout-Demo
//
//  Created by moxin on 2017/8/7.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "ViewController.h"
#import "PostListModel.h"
#import "PostListDataSource.h"
#import "PostListDelegate.h"
#import "PostListContext.h"


@interface ViewController ()

@property(nonatomic,strong) PostListDataSource* ds;
@property(nonatomic,strong) PostListDelegate* dl;
@property(nonatomic,strong) PostListModel* model;

@end

@implementation ViewController

- (PostListDelegate* )dl{
    if(!_dl){
        _dl = [PostListDelegate new];
    }
    return _dl;
}
- (PostListDataSource* )ds{
    if(!_ds){
        _ds = [PostListDataSource new];
    }
    return _ds;
}
- (PostListModel* )model{
    if(!_model){
        _model = [[PostListModel alloc]init];
        _model.key = @"post_list";
    }
    return _model;
}
- (id)init{
    self = [super init];
    if(self){
        [[PostListContext sharedInstance] setRootViewController:self];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder: aDecoder];
    if(self){
        [[PostListContext sharedInstance] setRootViewController:self];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(push)];
    
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.needPullRefresh = YES;
    self.dataSource = self.ds;
    self.delegate = self.dl;
    
    [self registerModel:self.model];
    self.keyModel = self.model;
    [self load];
}

- (void)push{
    
    
}

@end
