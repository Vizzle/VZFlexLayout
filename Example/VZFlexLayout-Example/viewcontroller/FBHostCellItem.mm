//
//  O2OFNodeListItem.m
//  O2O
//
//  Created by moxin on 16/4/21.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "FBHostItem.h"
#import "FBContentNode.h"
#import "FBHostNode.h"
#import "FBTextNode.h"
#import "FBScrollNode.h"
#import "FBHeaderNode.h"
#import "FBHostItem.h"
#import "FBHostCellItem.h"
#import <VZFlexLayout/VZFNodeListItemRecycler.h>


@interface FBHostCellItem () <VZFNodeProvider>

@property (nonatomic, strong) VZFNodeListItemRecycler *recycler;
@end


@implementation FBHostCellItem
{
//    VZFNodeListRecycleState _recycleState;
    FBHostItem* _model;
}

- (float)itemHeight
{
    return _recycler.layoutSize.height;
}
- (float)itemWidth
{
    return _recycler.layoutSize.width;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _recycler = [[VZFNodeListItemRecycler alloc] initWithNodeProvider:[self class] ];
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

- (void)setStore:(VZFluxStore *)store{

    _store = store;
    _recycler.store = store;
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


+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(FBHostItem* )item Store:(id)store Context:(NSIndexPath* )context{
    
    if([item.type isEqualToString:@"scroll"]){
        return [FBScrollNode newWithProps:item Store:store Context:context];
    }
    else{
        return [FBHostNode newWithProps:item Store:store Context:context];
    }
}

@end
