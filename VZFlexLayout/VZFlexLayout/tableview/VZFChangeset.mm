//
//  VZFChangeset.m
//  VZFlexLayout
//
//  Created by Sleen on 16/3/4.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFChangeset.h"

namespace VZ {
    
    void Changeset::updateItem(const VZ::IndexPath &indexPath, id item) {
        _itemUpdates[indexPath.section][indexPath.item] = item;
    }
    
    void Changeset::removeItem(const VZ::IndexPath &indexPath) {
        _itemRemovals[indexPath.section].insert(indexPath.item);
    }
    
    void Changeset::insertItem(const VZ::IndexPath &indexPath, id item) {
        _itemInsertions[indexPath.section][indexPath.item] = item;
    }
    
    void Changeset::moveItem(const VZ::IndexPath &fromIndexPath, const VZ::IndexPath &toIndexPath) {
        _itemMoves[fromIndexPath.section][fromIndexPath.item] = (NSIndexPath *)toIndexPath;
    }
    
    void Changeset::updateSection(NSInteger section, id sectionItem) {
        _sectionUpdates[section] = sectionItem;
    }
    
    void Changeset::removeSection(NSInteger section) {
        _sectionRemovals.insert(section);
    }
    
    void Changeset::insertSection(NSInteger section, id sectionItem) {
        _sectionInsertions[section] = sectionItem;
    }
    
    void Changeset::moveSection(NSInteger fromSection, NSInteger toSection) {
        _sectionMoves.insert(std::make_pair(fromSection, toSection));
    }
    
    
    void Changeset::enumerateItemUpdates(void(^block)(const IndexPath& indexPath, id item, BOOL *stop)) const {
        if (block) {
            BOOL stop = NO;
            for (const auto& section : _itemUpdates) {
                for (const auto& item : section.second) {
                    block({section.first, item.first}, item.second, &stop);
                    if (stop) break;
                }
                if (stop) break;
            }
        }
    }
    
    void Changeset::enumerateItemRemovals(void(^block)(const IndexPath& indexPath, BOOL *stop)) const {
        if (block) {
            BOOL stop = NO;
            for (const auto& section : _itemRemovals) {
                for (const auto& item : section.second) {
                    block({section.first, item}, &stop);
                    if (stop) break;
                }
                if (stop) break;
            }
        }
    }
    
    void Changeset::enumerateItemInsertions(void(^block)(const IndexPath& indexPath, id item, BOOL *stop)) const {
        if (block) {
            BOOL stop = NO;
            for (const auto& section : _itemInsertions) {
                for (const auto& item : section.second) {
                    block({section.first, item.first}, item.second, &stop);
                    if (stop) break;
                }
                if (stop) break;
            }
        }
    }
    
    void Changeset::enumerateItemMoves(void(^block)(const IndexPath& fromIndexPath, const IndexPath& toIndexPath, BOOL *stop)) const {
        if (block) {
            BOOL stop = NO;
            for (const auto& section : _itemMoves) {
                for (const auto& item : section.second) {
                    block({section.first, item.first}, item.second, &stop);
                    if (stop) break;
                }
                if (stop) break;
            }
        }
    }
    
    void Changeset::enumerateSectionUpdates(void(^block)(NSInteger section, id sectionItem, BOOL *stop)) const {
        if (block) {
            BOOL stop = NO;
            for (const auto& section : _sectionUpdates) {
                block(section.first, section.second, &stop);
                if (stop) break;
            }
        }
    }
    
    void Changeset::enumerateSectionRemovals(void(^block)(NSInteger section, BOOL *stop)) const {
        if (block) {
            BOOL stop = NO;
            for (const auto& section : _sectionRemovals) {
                block(section, &stop);
                if (stop) break;
            }
        }
    }
    
    void Changeset::enumerateSectionInsertions(void(^block)(NSInteger section, id sectionItem, BOOL *stop)) const {
        if (block) {
            BOOL stop = NO;
            for (const auto& section : _sectionInsertions) {
                block(section.first, section.second, &stop);
                if (stop) break;
            }
        }
    }
    
    void Changeset::enumerateSectionMoves(void(^block)(NSInteger fromSection, NSInteger toSection, BOOL *stop)) const {
        if (block) {
            BOOL stop = NO;
            for (const auto& section : _sectionMoves) {
                block(section.first, section.second, &stop);
                if (stop) break;
            }
        }
    }
    
    void Changeset::enumerateItems(id(^block)(id item)) {
        for (auto& section : _itemUpdates) {
            for (auto& item : section.second) {
                item.second = block(item.second);
            }
        }
        for (auto& section : _itemInsertions) {
            for (auto& item : section.second) {
                item.second = block(item.second);
            }
        }
//        for (auto& section : _sectionUpdates) {
//            section.second = block(section.second);
//        }
//        for (auto& section : _sectionInsertions) {
//            section.second = block(section.second);
//        }
    }
    
}
