//
//  VZFTableViewDataSource.h
//  VZFlexLayout
//
//  Created by Sleen on 16/3/1.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeHostingView.h"
#import "VZFChangeset.h"

@interface VZFTableViewDataSource : NSObject

@property (nonatomic, strong, readonly) UITableView *tableView;

- (instancetype)initWithTableView:(UITableView *)tableView nodeProvider:(id<VZFNodeProvider>)nodeProvider;

- (void)applyChangeset:(VZ::Changeset)changeset;

@end
