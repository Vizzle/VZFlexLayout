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
 * 处理node在列表中的显示
 */
@interface VZFNodeListItemRecycler : NSObject

@property(nonatomic,strong)VZFluxStore* store;
@property(nonatomic,strong) NSIndexPath* indexPath;
@property(nonatomic,assign,readonly) CGSize layoutSize;


/**
 提供列表的根节点node

 @param nodeProvider 提供node的类方法

 @return instance
 */
- (instancetype)initWithNodeProvider:(Class<VZFNodeProvider>)nodeProvider;


/**
 计算Node树的layout size

 @param item            model
 @param constrainedSize 目标区域矩形
 @param context         附加context信息
 @discussion: 重新计算layout会导致原缓存的layout释放，会导致node的引用计数-1。如果该方法在异步线程执行，则node可能再异步线程释放
 */
- (void)calculate:(id)item constrainedSize:(CGSize)constrainedSize context:(id<NSObject>)context;

/**
 @discussion: 当store中state变化或者node变化时调用
 */
- (void)updateState;


/**
 主线程同步渲染Root Node
 @param view 根RootView
 */
- (void)attachToView:(UIView *)view;
/**
 主线程异步渲染Root Node
 @discussion 如果asyncDisplay设为true，那么默认光栅化整个根节点
 @param view 根RootView
 @param rasterizeUseCache 异步渲染的时候是否要使用缓存
 */
- (void)attachToView:(UIView *)view rasterizeUseCache:(BOOL)rasterizeUseCache;

/**
 从RootView中移除node
 */
- (void)detachFromView;




@end


@interface UIView(ListRecycleController)

@property(nonatomic,weak)VZFNodeListItemRecycler*  vz_recycler;
//上一次是否使用异步渲染
@property(nonatomic,strong)NSObject *useVZAsyncDisplayFlag;

@end
