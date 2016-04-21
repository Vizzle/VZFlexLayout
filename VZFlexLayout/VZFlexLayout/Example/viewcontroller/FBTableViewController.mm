//
//  FBTableViewController.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBTableViewController.h"
#import "FBHostItem.h"
#import "FBHostCell.h"
#import "VZFNodeItem.h"
#import "FBHostNode.h"
#import "VZFNodeLayout.h"
#import "VZFNodeInternal.h"
#import "VZFNodeSpecs.h"


@interface FBTableViewController()<UITableViewDataSource,UITableViewDelegate,VZFNodeItemCallback>

@property(nonatomic,strong)UITableView* tableView;

@end

@implementation FBTableViewController{

    NSMutableArray* _items;
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(reloadData)];
    
    _items = [NSMutableArray new];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self loadData];

}

- (void)loadData{

    NSString* path = [[NSBundle mainBundle] pathForResource:@"results" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
    
    NSArray* results = json[@"results"];
    
    for(NSDictionary* dict in results){
    
        FBHostItem* fbHostItem = [FBHostItem newWithJSON:dict];
        VZFNodeItem* item = [VZFNodeItem new];
        item.delegate = self;
        item.constrainedWidth = CGRectGetWidth(self.view.bounds);
        item.model = fbHostItem;
        [_items addObject:item];
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    VZFNodeItem* item = _items[indexPath.row];
    return item.height;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"abc"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"abc"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.delegate = self;
    }
//    cell.indexPath = indexPath;
    VZFNodeItem* item = _items[indexPath.row];
    item.indexPath = indexPath;
    [item attachToView:cell.contentView];

    return cell;
}

- (void)onItemSizeChanged:(CGSize)sz Index:(NSIndexPath *)indexPath{

    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

}

@end
