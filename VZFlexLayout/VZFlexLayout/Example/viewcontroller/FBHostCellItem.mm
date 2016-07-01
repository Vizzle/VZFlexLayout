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
//    VZFNodeListRecycleState _recycleState;
    FBHostItem* _model;
}

- (float)itemHeight
{
    return _recycler.resultSize.height;
}
- (float)itemWidth
{
    return _recycler.resultSize.width;
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
    
    [_recycler calculate:model constrainedSize:sz context:self.indexPath];
    

}

- (void)updateState{
    
    [_recycler updateState];
}

- (void)attachToView:(UIView *)view
{
    [_recycler attachToView:view];
}

- (void)detachFromView
{
    [_recycler detachFromView];
}

- (VZFNode *)nodeForItem:(FBHostItem* )item context:(NSIndexPath* )context
{

    if([item.type isEqualToString:@"scroll"]){
        return [FBScrollNode newWithItem:item IndexPath:context];
    }
    else{
        return [FBHostNode newWithItem:item IndexPath:context];
    }    
}

- (void)nodeStateDidChanged:(id)scopeId ShouldInvalidateToNewSize:(BOOL)b
{
    if ([self.delegate respondsToSelector:@selector(itemState:ChangedAtIndex:SizeChanged:)]) {
        [self.delegate itemState:scopeId ChangedAtIndex:self.indexPath SizeChanged:b];
    }
}

@end
