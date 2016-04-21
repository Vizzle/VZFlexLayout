//
//  VZFNodeItem.h
//  VZFlexLayout
//
//  Created by moxin on 16/4/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>


@class  VZFNode;
@protocol VZFNodeItemCallback <NSObject>

@optional
- (void)onItemSizeChanged:(CGSize)sz Index:(NSIndexPath* )indexPath;

@end
@interface VZFNodeItem : NSObject

@property(nonatomic,strong)NSIndexPath* indexPath;
@property(nonatomic,weak) id<VZFNodeItemCallback> delegate;
@property(nonatomic,assign) float constrainedWidth;
@property(nonatomic,assign,readonly) float height;
@property(nonatomic,strong) id model;

- (void)attachToView:(UIView* )view;
- (void)detach;

@end
