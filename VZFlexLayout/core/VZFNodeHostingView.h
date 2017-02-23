//
//  VZFNodeHostingView.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFSizeRange.h"
#import "VZFNodeProvider.h"
#import "VZFStateUpdateMode.h"


@class VZFNodeHostingView;
@class VZFNode;
@class VZFluxStore;
@protocol VZFNodeHostingView <NSObject>
@optional
- (void)hostingView:(VZFNodeHostingView* )view DidInvalidate:(CGSize )sz;

@end

/**
 *  HostingView用来承载RootNode
 *
 *  @discussion:如果需要考虑view复用的场景，不建议使用hostingview
 *  tableView cell复用的场景请使用VZFNodeListItemRecycler
 *
 */
@interface VZFNodeHostingView : UIView

@property(nonatomic,weak)id<VZFNodeHostingView> delegate;
@property(nonatomic,weak)VZFluxStore* store;
@property(nonatomic,assign)BOOL shouldResize;


- (id)initWithNodeProvider:(Class<VZFNodeProvider>)nodeProvider RangeType:(VZFSizeRange)rangeType;
- (void)update:(id)model context:(id)context;
- (void)updateState;
- (void)reset;

- (instancetype)init __attribute__((unavailable("Not the designated initializer")));
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("Not the designated initializer")));


@end
