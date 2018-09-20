//
//  PostItem.m
//  VZFlexlayout-Demo
//
//  Created by Tao Xu on 9/17/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import "PostItem.h"
#import "PostNode.h"
#import "PostItemStore.h"
#import "ViewController.h"
#import "PostListContext.h"


@interface PostItem()
@property(nonatomic,strong) VZFNodeListItemRecycler* recycler;
@end

@implementation PostItem

- (float) itemHeight{
    return MAX(0.0001, _recycler.layoutSize.height);
}
- (float) contentWidth{
    return _recycler.layoutSize.width;
}
- (float) contentHeight{
    return [self itemHeight];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _recycler = [[VZFNodeListItemRecycler alloc] initWithNodeProvider:[self class]];
        _store = [[PostItemStore alloc]initWithDispatcher:[PostListContext globalDispatcher]];
        __weak __typeof(self) weakSelf = self;
        [_store addListener:^(int32_t eventId, BOOL stateChanged) {
            if(stateChanged){
                __strong __typeof(self) strongSelf = weakSelf;
                if(strongSelf){
                    [strongSelf->_recycler updateState];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UITableView* tableView = [PostListContext globalTableView];
                        NSIndexPath* indexPath = strongSelf.indexPath;
                        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
                        if(cell){
                            [strongSelf->_recycler attachToView:cell.contentView];
                        }
                        
                    });
                }
            }
        }];

    }
    return self;
}

- (void)updateModelWithConstrainedSize:(CGSize)sz context:(id)context{
    [self.recycler calculate:self constrainedSize:sz context:context];
}
- (void)updateState{
    [self.recycler updateState];
    
}
- (void)attachToView:(UIView *)view{
    _attachedView = view;
    [self.recycler attachToView:view];
}
- (void)detachFromView{
    [self.recycler detachFromView];
    _attachedView = nil;
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(PostItem* )item Store:(VZFluxStore* )store Context:(id)ctx{
    return [PostNode newWithProps:item Store:item.store Context:ctx];
}

@end
