//
//  VZFNodeListAdapter.h
//  VZFlexLayout
//
//  Created by moxin on 16/4/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFSizeRange.h"
#import "VZFNodeLayout.h"
#import "VZFNodeProvider.h"

@class VZFluxStore;
using namespace VZ;

/**
 *  列表node的适配器
 */
@interface VZFNodeListItemRecycler : NSObject

@property(nonatomic,weak)VZFluxStore* store;
@property(nonatomic,strong) NSIndexPath* indexPath;
@property(nonatomic,assign,readonly) CGSize layoutSize;

- (instancetype)initWithNodeProvider:(Class<VZFNodeProvider>)nodeProvider;

- (void)calculate:(id)item constrainedSize:(CGSize)constrainedSize context:(id<NSObject>)context;

- (void)updateState;

- (void)attachToView:(UIView *)view;
- (void)attachToView:(UIView *)view asyncDisplay:(BOOL)asyncDisplay;

- (void)detachFromView;

- (BOOL)isAttachedToView;



@end


@interface UIView(ListRecycleController)

@property(nonatomic,weak)VZFNodeListItemRecycler*  vz_recycler;

@end
