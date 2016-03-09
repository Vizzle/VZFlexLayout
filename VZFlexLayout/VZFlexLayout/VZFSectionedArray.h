//
//  VZFSectionedArray.h
//  VZFlexLayout
//
//  Created by Sleen on 16/3/3.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFChangeset.h"

@interface VZFSectionedArray : NSObject

- (NSInteger)numberOfSections;

- (NSInteger)numberOfItemsInSection:(NSInteger)section;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (id)sectionItemAtSection:(NSInteger)section;

- (void)applyChangeset:(VZ::Changeset)changeset;

@end
