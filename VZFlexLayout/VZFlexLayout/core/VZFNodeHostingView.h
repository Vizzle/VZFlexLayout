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

@class VZFNodeHostingView;
@class VZFNode;
//@protocol VZFNodeProvider <NSObject>
//
//- (VZFNode *)nodeForItem:(id<NSObject>)item context:(id<NSObject>)context;
//
//@end

@protocol VZFNodeHostingView <NSObject>

@optional

- (void)hostingView:(VZFNodeHostingView* )view DidInvalidate:(CGSize)newSize;

@end


typedef NS_ENUM(NSUInteger,VZFUpdateMode){

    VZFUpdateModeAsynchronous,
    VZFUpdateModeSynchronous
};

@interface VZFNodeHostingView : UIView

@property(nonatomic,weak)id<VZFNodeHostingView> delegate;

- (id)initWithNodeProvider:(id<VZFNodeProvider>)nodeProvider RangeProvider:(id<VZSizeRangeProvider>)sizeProvider;
- (void)update:(id)model mode:(VZFUpdateMode)updateMode;


- (instancetype)init __attribute__((unavailable("Not the designated initializer")));
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("Not the designated initializer")));


@end
