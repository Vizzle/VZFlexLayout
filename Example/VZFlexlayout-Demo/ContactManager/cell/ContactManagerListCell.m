  
//
//  ContactManagerListCell.m
//  
//
//  Created by moxin on 2018-10-02 23:25:02 -0400.
//  Copyright (c) 2018年 . All rights reserved.
//



#import "ContactManagerListCell.h"
#import "ContactManagerListItem.h"

@interface ContactManagerListCell()

@end

@implementation ContactManagerListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //todo: add some UI code
    
        
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)setItem:(ContactManagerListItem *)item
{
    [super setItem:item];
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
  
  
}
@end
  
