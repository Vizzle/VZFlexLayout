  
//
//  ContactManagerListViewDataSource.m
//  
//
//  Created by moxin on 2018-10-02 23:25:02 -0400.
//  Copyright (c) 2018年 . All rights reserved.
//



#import "ContactManagerListViewDataSource.h"
#import "ContactManagerListCell.h"

@interface ContactManagerListViewDataSource()

@end

@implementation ContactManagerListViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //default:
    return 1; 

}

- (Class)cellClassForItem:(id)item AtIndex:(NSIndexPath *)indexPath{

    //@REQUIRED:
    
    return [ContactManagerListCell class];
    

}

//@optional:
//- (VZListItem* )itemForCellAtIndexPath:(NSIndexPath*)indexPath{

    //default:
    //return [super itemForCellAtIndexPath:indexPath]; 

//}


@end  
