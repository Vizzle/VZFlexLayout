//
//  FBHostCell.h
//  VZFlexLayout
//
//  Created by moxin on 16/4/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VZFNode;
@class VZFNodeItem;

@protocol FBHostCellAction <NSObject>

- (void)onCellClicked:(NSIndexPath* )indexPath WithNewSize:(CGSize)sz;

@end

@interface FBHostCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath* indexPath;
@property(nonatomic,weak)id<FBHostCellAction> delegate;

@property(nonatomic,strong) VZFNodeItem* item;


@end
