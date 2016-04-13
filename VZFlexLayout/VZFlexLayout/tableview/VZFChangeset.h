//
//  VZFChangeset.h
//  VZFlexLayout
//
//  Created by Sleen on 16/3/4.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <map>
#include <set>

namespace VZ {
    
    struct IndexPath {
        NSInteger section;
        NSInteger item;
        
        IndexPath() : section(NSNotFound), item(NSNotFound) {}
        IndexPath(NSInteger section, NSInteger item) : section(section), item(item) {}
        IndexPath(NSIndexPath *indexPath) : section(indexPath ? indexPath.section : NSNotFound), item(indexPath ? indexPath.row : NSNotFound) {}
        operator NSIndexPath *() const { return [NSIndexPath indexPathForItem:item inSection:section]; }
    };
    
    struct Changeset {
        typedef std::map<NSInteger, std::map<NSInteger, id>> ItemsMap;
        
        void updateItem(const IndexPath& indexPath, id item);
        void removeItem(const IndexPath& indexPath);
        void insertItem(const IndexPath& indexPath, id item);
        void moveItem(const IndexPath& fromIndexPath, const IndexPath& toIndexPath);
        void updateSection(NSInteger section, id sectionItem);
        void removeSection(NSInteger section);
        void insertSection(NSInteger section, id sectionItem);
        void moveSection(NSInteger fromSection, NSInteger toSection);
        
        void enumerateItemUpdates(void(^block)(const IndexPath& indexPath, id item, BOOL *stop)) const;
        void enumerateItemRemovals(void(^block)(const IndexPath& indexPath, BOOL *stop)) const;
        void enumerateItemInsertions(void(^block)(const IndexPath& indexPath, id item, BOOL *stop)) const;
        void enumerateItemMoves(void(^block)(const IndexPath& fromIndexPath, const IndexPath& toIndexPath, BOOL *stop)) const;
        void enumerateSectionUpdates(void(^block)(NSInteger section, id sectionItem, BOOL *stop)) const;
        void enumerateSectionRemovals(void(^block)(NSInteger section, BOOL *stop)) const;
        void enumerateSectionInsertions(void(^block)(NSInteger section, id sectionItem, BOOL *stop)) const;
        void enumerateSectionMoves(void(^block)(NSInteger fromSection, NSInteger toSection, BOOL *stop)) const;
        
        void enumerateItems(id(^block)(id item));
        
    private:
        ItemsMap _itemUpdates;
        std::map<NSInteger, std::set<NSInteger>> _itemRemovals;
        ItemsMap _itemInsertions;
        ItemsMap _itemMoves;
        std::map<NSInteger, id> _sectionUpdates;
        std::map<NSInteger, id> _sectionInsertions;
        std::set<NSInteger> _sectionRemovals;
        std::set<std::pair<NSInteger, NSInteger>> _sectionMoves;
    };
}
