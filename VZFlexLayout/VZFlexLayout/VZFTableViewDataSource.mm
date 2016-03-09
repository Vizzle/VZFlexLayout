//
//  VZFTableViewDataSource.m
//  VZFlexLayout
//
//  Created by Sleen on 16/3/1.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFTableViewDataSource.h"
#import "VZFSectionedArray.h"
#import "VZFlexCell.h"
#import "VZFSectionedArray.h"
#import "VZFNodeInternal.h"
#import "VZFNodeViewManager.h"

@interface VZFItem : NSObject

@property (nonatomic, strong) id item;
@property (nonatomic, strong) VZFNode *node;
@property (nonatomic) VZFNodeLayout layout;
//@property (nonatomic) 

@end

@implementation VZFItem

@end

@interface VZFTableViewDataSource () <UITableViewDataSource, UITableViewDelegate>
{
    Class<VZFNodeProvider> _nodeProvider;
    VZFSectionedArray *_sectionedArray;
}
@end

@implementation VZFTableViewDataSource

static NSString *const kVZFTableViewCellReuseIdentifier = @"kVZFTableViewCellReuseIdentifier";

- (instancetype)initWithTableView:(UITableView *)tableView nodeProvider:(id<VZFNodeProvider>)nodeProvider {
    if (self = [super init]) {
        _nodeProvider = [nodeProvider class];
        _tableView = tableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[VZFlexCell class] forCellReuseIdentifier:kVZFTableViewCellReuseIdentifier];
        _sectionedArray = [[VZFSectionedArray alloc] init];
    }
    return self;
}

- (void)applyChangeset:(VZ::Changeset)changeset {
    // wraps items into VZFItem
    changeset.enumerateItems(^id(id item) {
        VZFNode *node = [_nodeProvider nodeForItem:item context:nil];
        VZFNodeLayout layout = [node computeLayoutThatFits:CGSizeMake(self.tableView.bounds.size.width, FlexInfinite)];
        VZFItem *vzfItem = [[VZFItem alloc] init];
        vzfItem.item = item;
        vzfItem.node = node;
        vzfItem.layout = layout;
        return vzfItem;
    });
    
    [_sectionedArray applyChangeset:changeset];
    UITableViewRowAnimation animation = UITableViewRowAnimationFade;
    [_tableView beginUpdates];
    NSMutableArray *itemUpdateIndexPaths = [NSMutableArray array];
    NSMutableArray *itemRemovalIndexPaths = [NSMutableArray array];
    NSMutableArray *itemInsertionIndexPaths = [NSMutableArray array];
    NSMutableIndexSet *sectionUpdateIndexSet = [NSMutableIndexSet indexSet];
    NSMutableIndexSet *sectionRemovalIndexSet = [NSMutableIndexSet indexSet];
    NSMutableIndexSet *sectionInsertionIndexSet = [NSMutableIndexSet indexSet];
    changeset.enumerateItemUpdates(^(const VZ::IndexPath &indexPath, id item, BOOL *stop) {
        [itemUpdateIndexPaths addObject:indexPath];
    });
    changeset.enumerateItemRemovals(^(const VZ::IndexPath &indexPath, BOOL *stop) {
        [itemRemovalIndexPaths addObject:indexPath];
    });
    changeset.enumerateItemInsertions(^(const VZ::IndexPath &indexPath, id item, BOOL *stop) {
        [itemInsertionIndexPaths addObject:indexPath];
    });
    changeset.enumerateItemMoves(^(const VZ::IndexPath &fromIndexPath, const VZ::IndexPath &toIndexPath, BOOL *stop) {
        [_tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    });
    changeset.enumerateSectionUpdates(^(NSInteger section, id sectionItem, BOOL *stop) {
        [sectionUpdateIndexSet addIndex:section];
    });
    changeset.enumerateSectionRemovals(^(NSInteger section, BOOL *stop) {
        [sectionRemovalIndexSet addIndex:section];
    });
    changeset.enumerateSectionInsertions(^(NSInteger section, id sectionItem, BOOL *stop) {
        [sectionInsertionIndexSet addIndex:section];
    });
    changeset.enumerateSectionMoves(^(NSInteger fromSection, NSInteger toSection, BOOL *stop) {
        [_tableView moveSection:fromSection toSection:toSection];
    });
    [_tableView reloadRowsAtIndexPaths:itemUpdateIndexPaths withRowAnimation:animation];
    [_tableView deleteRowsAtIndexPaths:itemRemovalIndexPaths withRowAnimation:animation];
    [_tableView insertRowsAtIndexPaths:itemInsertionIndexPaths withRowAnimation:animation];
    [_tableView reloadSections:sectionUpdateIndexSet withRowAnimation:animation];
    [_tableView deleteSections:sectionRemovalIndexSet withRowAnimation:animation];
    [_tableView insertSections:sectionInsertionIndexSet withRowAnimation:animation];
    [_tableView endUpdates];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_sectionedArray numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_sectionedArray numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VZFlexCell *cell = [tableView dequeueReusableCellWithIdentifier:kVZFTableViewCellReuseIdentifier forIndexPath:indexPath];
    VZFItem *item = [_sectionedArray itemAtIndexPath:indexPath];
    UIView *oldView = cell.contentView.subviews.count > 0 ? cell.contentView.subviews[0] : nil;
    UIView *view = [VZFNodeViewManager viewForNode:item.node withLayoutSpec:item.layout reuseView:oldView];
    view.frame = {item.layout.nodeOrigin(), view.frame.size};
    if (view != oldView) {
        [oldView removeFromSuperview];
        [cell.contentView addSubview:view];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    VZFItem *item = [_sectionedArray itemAtIndexPath:indexPath];
    return item.layout.nodeSize().height + item.layout.nodeMargin().top + item.layout.nodeMargin().bottom;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self numberOfSectionsInTableView:tableView] - 1 && indexPath.row == [self tableView:tableView numberOfRowsInSection:indexPath.section] - 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollToBottom" object:nil];
    }
}

@end
