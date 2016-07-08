//
//  FBTableViewController.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBTableViewController.h"
#import "FBHostItem.h"
#import "FBHostNode.h"
#import "VZFNodeLayout.h"
#import "VZFNodeInternal.h"
#import "VZFNodeSpecs.h"
#import "FBTextNode.h"
#import "FBHostCellItem.h"
#import "VZFlux.h"
#import "FBActionType.h"
#import "FBScrollNodeStore.h"
#import "FBContentNodeStore.h"


@interface FBTableViewController()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)FBContentNodeStore* contentStore;

@end

@implementation FBTableViewController{

    NSMutableArray* _items;
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(reloadData)];
    
    _items = [NSMutableArray new];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    
    self.contentStore = [[FBContentNodeStore alloc]initWithDispatcher:[VZFluxAppDispatcher dispatcher]];
    __weak typeof(self) weakSelf = self;
    [self.contentStore addListener:^(NSString *eventType, NSDictionary*  data) {
       
        if ([eventType isEqualToString:@"change"]) {
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSIndexPath* indexPath = data[@"index"];
            unsigned long row = indexPath.row;
            FBHostCellItem* item = strongSelf->_items[row];
            [item updateState];
            [weakSelf.tableView reloadData];
            
        }
        
    }];
    
//    self.scrollStore = (FBScrollNodeStore* )[VZFluxStoreFactory storeWithClass:[FBScrollNodeStore class]];
//    [self.scrollStore addListener:^(NSString *eventType, id data) {
//        NSLog(@"%@",data);
//        
//    }];
    
    
    [self loadData];
    
    

}

- (void)loadData{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSString* path = [[NSBundle mainBundle] pathForResource:@"results" ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:path];
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
        
        NSArray* results = json[@"results"];
        
        for(int i = 0; i<results.count; i++){
            
            FBHostItem* model = [FBHostItem newWithJSON:results[i]];
            FBHostCellItem* item = [FBHostCellItem new];
            item.indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.contentStore addNewState];
            item.store = self.contentStore;
            [item updateModel:model constrainedSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, VZ::FlexValue::Auto)];
            [_items addObject:item];
        }        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    });


    
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

- (void)itemState:(id)scopeId ChangedAtIndex:(NSIndexPath* )indexPath SizeChanged:(BOOL)b{
    
    if (b) {
        [self.tableView reloadData];
    }

}

- (void)reloadData{

    [_items removeAllObjects];
    [self loadData];
    
}

@end
