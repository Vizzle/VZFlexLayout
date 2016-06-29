//
//  O2OFNodeListItem.m
//  O2O
//
//  Created by moxin on 16/4/21.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "FBHostItem.h"
#import "VZFNodeListItemRecycler.h"
#import "FBContentNode.h"
#import "FBHostNode.h"
#import "FBTextNode.h"
#import "FBScrollNode.h"
#import "FBHeaderNode.h"
#import "FBHostItem.h"
#import "FBHostCellItem.h"

@interface FBHostCellItem () <VZFNodeProvider, VZFNodeListItemRecycleController>

@property (nonatomic, strong) VZFNodeListItemRecycler *recycler;
@end


@implementation FBHostCellItem
{
    VZFNodeListRecycleState _recycleState;
    FBHostItem* _model;
}

- (float)itemHeight
{
    return _recycleState.layout.size.height + _recycleState.layout.margin.top + _recycleState.layout.margin.bottom;
}
- (float)itemWidth
{
    return _recycleState.layout.size.width + _recycleState.layout.margin.left + _recycleState.layout.margin.right;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _recycler = [[VZFNodeListItemRecycler alloc] initWithNodeProvider:self SizeRangeProvider:[VZSizeRangeProvider defaultRangeProvider:VZFlexibleSizeHeight]];
        _recycler.delegate = self;
    }
    return self;
}

- (NSString* )reuseIdentifier{
    
    return _model.type;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    _recycler.indexPath = indexPath;
}

- (void)updateModel:(id)model constrainedSize:(CGSize)sz{
    
    _model = model;
    
    _recycleState = [_recycler calculate:model constrainedSize:sz context:nil];
    
    [_recycler updateState:_recycleState];

}

- (void)attachToView:(UIView *)view
{
    [_recycler attachToView:view];
}

- (void)detachFromView
{
    [_recycler detachFromView];
}

- (VZFNode *)nodeForItem:(FBHostItem* )item context:(id<NSObject>)context
{

    if([item.type isEqualToString:@"scroll"]){
        return [FBScrollNode newWithItem:item];
    }
    else{
        return [FBHostNode newWithItem:item];
    }    
}

- (void)nodeStateDidChanged:(id)scopeId ShouldInvalidateToNewSize:(BOOL)b
{
    if ([self.delegate respondsToSelector:@selector(itemState:ChangedAtIndex:SizeChanged:)]) {
        [self.delegate itemState:scopeId ChangedAtIndex:self.indexPath SizeChanged:b];
    }
}

@end
