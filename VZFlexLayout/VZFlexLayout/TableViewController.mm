//
//  TableViewController.m
//  VZFlexLayout
//
//  Created by 俞伟平 on 2/23/16.
//  Copyright © 2016 Vizlab. All rights reserved.
//

#import "TableViewController.h"
#import "VZFNode.h"
#import "VZFlexCell.h"
#import "DemoCell.h"
#import "VZFNodeViewManager.h"
#import "VZFTableViewDataSource.h"
#import "FBHostNode.h"
#import "FBHostItem.h"

@interface TableViewController ()<UITableViewDelegate, VZFNodeProvider>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) VZFTableViewDataSource *dataSource;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self renderTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enqueueItems) name:@"scrollToBottom" object:nil];
}


- (void)renderTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    _dataSource = [[VZFTableViewDataSource alloc] initWithTableView:self.tableView nodeProvider:self];
    
    [self.view addSubview:self.tableView];
    
    VZ::Changeset changeset;
    changeset.insertSection(0, @"Section");
    for (int i=0;i<5;i++) {
        NSString* path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"result%d", (rand()%2)+1] ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:path];
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
        FBHostItem* item = [FBHostItem newWithJSON:json];
        changeset.insertItem({0, i}, item);
    }
    [_dataSource applyChangeset:changeset];
}

- (void)enqueueItems {
    VZ::Changeset changeset;
    NSInteger numberOfItems = [self.tableView numberOfRowsInSection:0];
    for (int i=0;i<5;i++) {
        NSString* path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"result%d", (rand()%2)+1] ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:path];
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
        FBHostItem* item = [FBHostItem newWithJSON:json];
        changeset.insertItem({0, numberOfItems++}, item);
    }
    [_dataSource applyChangeset:changeset];
}

+ (VZFNode *)nodeForItem:(FBHostItem *)item context:(id<NSObject>)context {
    return [FBHostNode newWithItem:item];
}

@end
