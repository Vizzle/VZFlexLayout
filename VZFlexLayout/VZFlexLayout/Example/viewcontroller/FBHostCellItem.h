//
//  O2OFNodeListItem.h
//  O2O
//
//  Created by moxin on 16/4/21.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FBHostItemDelegate <NSObject>

@optional
- (void)itemState:(id)scopeId ChangedAtIndex:(NSIndexPath* )indexPath SizeChanged:(BOOL)b;

@end


@class VZFNode;
@interface FBHostCellItem : NSObject

@property(nonatomic,strong) NSString* reuseIdentifier;
@property(nonatomic,strong) NSIndexPath* indexPath;
@property(nonatomic,weak) id<FBHostItemDelegate> delegate;
//计算后的item宽度
@property(nonatomic,assign,readonly)float itemWidth;
@property(nonatomic,assign,readonly)float itemHeight;
/**
 *  计算node的layout，默认constrainedSize = {screenWidth, flex::auto}
 *
 *  @param model 
 */
- (void)updateModel:(id)model constrainedSize:(CGSize)sz;
- (void)attachToView:(UIView* )view;
- (void)detachFromView;

@end

