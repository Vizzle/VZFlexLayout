//
//  FBHostCell.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBHostCell.h"
#import "VZFNode.h"
#import "VZFNodeHostingView.h"
#import "VZFSizeRange.h"
#import "VZFNodeItem.h"
#import "FBHostNode.h"

@interface FBHostCell()<VZFNodeHostingView,VZFNodeProvider>{

    VZFNodeHostingView* _hostingView;
}

@end

@implementation FBHostCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _hostingView = [[VZFNodeHostingView alloc]initWithNodeProvider:self RangeProvider:[VZSizeRangeProvider defaultRangeProvider:VZFlexibleSizeHeight]];
        _hostingView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 1);
        _hostingView.backgroundColor = [UIColor whiteColor];
        _hostingView.delegate = self;
        [self.contentView addSubview:_hostingView];
        
    }
    return self;

}

- (void)setItem:(VZFNodeItem *)item{
    
    _item = item;
//    [_hostingView update:item.contentItem mode:VZFUpdateModeSynchronous];

}

- (void)hostingView:(VZFNodeHostingView* )view DidInvalidate:(CGSize)newSize{

    _hostingView.frame = CGRect{{0,0},newSize};
//    if ([self.delegate respondsToSelector:@selector(onCellClicked:WithNewSize:)]) {
//        [self.delegate onCellClicked:self.indexPath WithNewSize:newSize];
//    }
//    

}

- (VZFNode* )nodeForItem:(FBHostItem* )item context:(id<NSObject>)context{
    
//    return self.item.node;
    FBHostNode* node = [FBHostNode newWithItem:item];
    return node;
    
}

- (void)layoutSubviews{

    [super layoutSubviews];

}


@end
