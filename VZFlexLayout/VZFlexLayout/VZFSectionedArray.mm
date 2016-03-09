//
//  VZFSectionedArray.m
//  VZFlexLayout
//
//  Created by Sleen on 16/3/3.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFSectionedArray.h"

#include <vector>

namespace VZ {
    
    struct Section {
        id sectionItem;
        NSMutableArray *items;
    };
    
}

@interface VZFSection : NSObject

@property (nonatomic, strong) id sectionItem;
@property (nonatomic, strong) NSMutableArray *items;

- (instancetype)initWithSectionItem:(id)sectionItem;

@end

@implementation VZFSection

- (instancetype)initWithSectionItem:(id)sectionItem {
    if (self = [super init]) {
        _sectionItem = sectionItem;
        _items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)init {
    return [self initWithSectionItem:nil];
}

@end

@interface VZFSectionedArray ()
{
//    std::vector<VZ::Section> _sections;
    NSMutableArray<VZFSection*> *_sections;
}
@end

@implementation VZFSectionedArray

- (instancetype)init {
    if (self = [super init]) {
        _sections = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger)numberOfSections {
//    return _sections.size();
    return _sections.count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return _sections[section].items.count;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return _sections[indexPath.section].items[indexPath.row];
}

- (id)sectionItemAtSection:(NSInteger)section {
    return _sections[section].sectionItem;
}

- (void)applyChangeset:(VZ::Changeset)changeset {
    // 1. item updates
    changeset.enumerateItemUpdates(^(const VZ::IndexPath &indexPath, id item, BOOL *stop) {
        _sections[indexPath.section].items[indexPath.item] = item;
    });
    
    // 2. item removals
    __block std::map<NSInteger, NSMutableIndexSet *> itemRemovalIndexes;
    changeset.enumerateItemRemovals(^(const VZ::IndexPath &indexPath, BOOL *stop) {
        if (itemRemovalIndexes.count(indexPath.section)) {
            [itemRemovalIndexes[indexPath.section] addIndex:indexPath.item];
        }
        else {
            itemRemovalIndexes[indexPath.section] = [NSMutableIndexSet indexSetWithIndex:indexPath.item];
        }
    });
    for (const auto& removalsInSection : itemRemovalIndexes) {
        [_sections[removalsInSection.first].items removeObjectsAtIndexes:removalsInSection.second];
    }
    
    // 3. section updates
    changeset.enumerateSectionUpdates(^(NSInteger section, id sectionItem, BOOL *stop) {
        _sections[section].sectionItem = sectionItem;
    });
    
    // 4. section removals
    NSMutableIndexSet *sectionRemovalIndexes = [NSMutableIndexSet indexSet];
    changeset.enumerateSectionRemovals(^(NSInteger section, BOOL *stop) {
        [sectionRemovalIndexes addIndex:section];
    });
    [_sections removeObjectsAtIndexes:sectionRemovalIndexes];
    
    // 5. section insertions
    NSMutableArray *sections = [[NSMutableArray alloc] init];
    NSMutableIndexSet *sectionInsertionIndexes = [NSMutableIndexSet indexSet];
    changeset.enumerateSectionInsertions(^(NSInteger section, id sectionItem, BOOL *stop) {
        [sections addObject:[[VZFSection alloc] initWithSectionItem:sectionItem]];
        [sectionInsertionIndexes addIndex:section];
    });
    [_sections insertObjects:sections atIndexes:sectionInsertionIndexes];
    
    // 6. section moves
    changeset.enumerateSectionMoves(^(NSInteger fromSection, NSInteger toSection, BOOL *stop) {
        id section = _sections[fromSection];
        [_sections removeObjectAtIndex:fromSection];
        [_sections insertObject:section atIndex:toSection];
    });
    
    // 7. item insertion
    __block std::map<NSInteger, std::pair<NSMutableIndexSet *, NSMutableArray *>> itemInsertionIndexes;
    changeset.enumerateItemInsertions(^(const VZ::IndexPath &indexPath, id item, BOOL *stop) {
        if (!itemInsertionIndexes.count(indexPath.section)) {
            itemInsertionIndexes[indexPath.section] = std::make_pair([NSMutableIndexSet indexSet], [NSMutableArray array]);
        }
        [itemInsertionIndexes[indexPath.section].first addIndex:indexPath.item];
        [itemInsertionIndexes[indexPath.section].second addObject:item];
    });
    for (const auto& insertionsInSection : itemInsertionIndexes) {
        [_sections[insertionsInSection.first].items insertObjects:insertionsInSection.second.second atIndexes:insertionsInSection.second.first];
    }
    
    // 8. item moves
    changeset.enumerateItemMoves(^(const VZ::IndexPath &fromIndexPath, const VZ::IndexPath &toIndexPath, BOOL *stop) {
        id item = _sections[fromIndexPath.section].items[fromIndexPath.item];
        [_sections[fromIndexPath.section].items removeObjectAtIndex:fromIndexPath.item];
        [_sections[toIndexPath.section].items insertObject:item atIndex:toIndexPath.item];
    });
}

@end
