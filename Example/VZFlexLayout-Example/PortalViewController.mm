//
//  ViewController.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/13.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "PortalViewController.h"
#import "FBViewController.h"
#import "FBTableViewController.h"
#import "FBTextListViewController.h"

static NSString *const kItemTitleKey = @"title";
static NSString *const kItemSubtitleKey = @"subtitle";
static NSString *const kItemTargetClassKey = @"targetClass";

@interface PortalViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSDictionary *> *items;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PortalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTitleView];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.rowHeight = 44.0f;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self loadTableData];
}

- (void)setupTitleView {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"AvenirNextCondensed-Bold" size:20.0];
    label.text = @"VZFlexLayout";
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

- (void)loadTableData {
    NSArray *data = @[
                   @{kItemTitleKey: @"TextField", kItemSubtitleKey: @"VZFTextFieldNode", kItemTargetClassKey: @"TextFieldNodeViewController"},
                   @{kItemTitleKey: @"Switch", kItemSubtitleKey: @"VZFSwitchNode", kItemTargetClassKey: @"SwitchNodeViewController"},
                   @{kItemTitleKey: @"Picker", kItemSubtitleKey: @"VZFPickerNode", kItemTargetClassKey: @"PickerNodeViewController"},
                   @{kItemTitleKey: @"Application", kItemSubtitleKey: @"A comprehensive demo", kItemTargetClassKey: @"FBTableViewController"},
                   @{kItemTitleKey: @"SegmentedControl", kItemSubtitleKey: @"VZFSegmentedControlNode", kItemTargetClassKey: @"SegmentedControlNodeViewController"},
                   @{kItemTitleKey: @"WebView", kItemSubtitleKey: @"VZFWebViewNode", kItemTargetClassKey: @"WebViewNodeViewController"},
                   @{kItemTitleKey: @"MapView", kItemSubtitleKey: @"VZFMapViewNode", kItemTargetClassKey: @"MapViewNodeViewController"}
                   ];
    
    self.items = [data sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *title1 = obj1[kItemTitleKey];
        NSString *title2 = obj2[kItemTitleKey];
        return [title1 compare:title2];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"PortalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:102.0/255.0 alpha:1];
    }
    NSDictionary<NSString *, NSString *> *item = self.items[indexPath.row];
    cell.textLabel.text = item[kItemTitleKey];
    cell.detailTextLabel.text = item[kItemSubtitleKey];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary<NSString *, NSString *> *item = self.items[indexPath.row];
    id viewController = [NSClassFromString(item[kItemTargetClassKey]) new];
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
