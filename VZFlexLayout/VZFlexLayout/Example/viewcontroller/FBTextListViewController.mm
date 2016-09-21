//
//  FBTextListViewController.m
//  VZFlexLayout
//
//  Created by moxin on 16/9/10.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBTextListViewController.h"
#import "FBHostItem.h"
#import "FBHostCellItem.h"
#import "VZFTextNode.h"


@interface FBTextListViewController()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView* tableView;

@end

@implementation FBTextListViewController
{
    NSMutableArray* _items;
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    _items = [NSMutableArray new];
    
    
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
    //});
    
}

- (void)loadData{
    

    NSString* longtext = @"In my opinion, a lot of this confusion is cleared up by understanding the core function invocation primitive, and then looking at all other ways of invoking a function as sugar on top of that primitive. In fact, this is exactly how the ECMAScript spec thinks about it. In some areas, this post is a simplification of the spec, but the basic idea is the same.";
    
    NSString* shortText = @"asdfafasdfafd";
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            for(int i=0; i<50; i++){
                
                NSString* content = longtext;
                
                if (i==0) {
                    content = shortText;
                }
                FBHostItem* item = [FBHostItem newWithJSON:@{@"content":content}];
                FBHostCellItem* fbItem = [FBHostCellItem new];
                fbItem.indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                
                [fbItem updateModel:item constrainedSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, VZ::FlexValue::Auto)];
                
                [_items addObject:fbItem];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
           }
            
        });
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self loadData];
//    });
    
//        for(int i = 0; i<results.count; i++){
//            
//            FBHostItem* model = [FBHostItem newWithJSON:results[i]];
//            FBHostCellItem* item = [FBHostCellItem new];
//            item.indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            [self.contentStore addNewState];
//            item.store = self.contentStore;
//            [item updateModel:model constrainedSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, VZ::FlexValue::Auto)];
//            [_items addObject:item];
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [self.tableView reloadData];
//        });

    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FBHostCellItem* item = _items[indexPath.row];
    return item.itemHeight;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FBHostCellItem* item = _items[indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.delegate = self;
    }
    //    cell.indexPath = indexPath;
    
    item.indexPath = indexPath;
    [item attachToView:cell.contentView];
    
    return cell;
}








@end
