//
//  PostListDataSource.m
//  VZFlexlayout-Demo
//
//  Created by Tao Xu on 9/17/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import "PostListDataSource.h"
#import "PostListCell.h"
#import "PostItem.h"

@implementation PostListDataSource



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (Class)cellClassForItem:(VZListItem *)item AtIndex:(NSIndexPath *)indexPath{
    return [PostListCell class];
}
- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    PostItem* item = (PostItem* )[self itemForCellAtIndexPath:indexPath];
    [item attachToView:cell.contentView];
    
    return cell;
}

@end
