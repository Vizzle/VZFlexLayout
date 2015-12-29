//
//  VZFlexNode.h
//  VZFlexLayout
//
//  Created by moxin on 15/12/25.
//  Copyright © 2015年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,VZFlexNodeDirection){
    
    VZFLEX_DIRECTION_COLUMN = 0,
    VZFLEX_DIRECTION_COLUMN_REVERSE,
    VZFLEX_DIRECTION_ROW,
    VZFLEX_DIRECTION_ROW_REVERSE
};

typedef NS_ENUM(NSInteger,VZFlexNodeAlignItems)
{
    VZFLEX_ALIGN_ITEMS_START=0,
    VZFLEX_ALIGN_ITEmCENTER,
    VZFLEX_ALIGN_FLEX_END,
    VZFLEX_ALIGN_STRETCH
};
typedef NS_ENUM(NSInteger,VZFlexNodeAlignContent)
{
    VZFLEX_ALIGN_CONTENT_START=0,
    VZFLEX_ALIGN_CONTENT_CENTER,
    VZFLEX_ALIGN_CONTENT_END,
    VZFLEX_ALIGN_CONTENT_STRETCH
};

typedef NS_ENUM(NSInteger,VZFlexNodeJustifyContent)
{
    VZFLEX_JC_START = 0,
    VZFLEX_JC_CENTER,
    VZFLEX_JC_END,
    VZFLEX_JC_SPACE_BETWEEN,
    VZFLEX_JC_SPACE_AROUND
};


typedef CGFloat VZFlexNodeFlexValue;



@interface VZFlexNode : NSObject

@property (nonatomic,strong,readonly) UIView* view;
@property (nonatomic,assign,readonly) CGRect frame;

@property (nonatomic,strong,readonly) NSArray* childNodes;
@property (nonatomic, copy) CGSize (^measureBlock)(CGFloat width);

@property (nonatomic,strong)NSString* name;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)UIEdgeInsets margin;
@property (nonatomic,assign)UIEdgeInsets padding;
@property (nonatomic,assign)VZFlexNodeDirection flexDirection;
@property (nonatomic,assign)VZFlexNodeAlignItems alignItems;
@property (nonatomic,assign)VZFlexNodeAlignContent alignContent;
@property (nonatomic,assign)VZFlexNodeJustifyContent justifyContent;
@property (nonatomic,assign)VZFlexNodeFlexValue flexValue;

- (void)layout:(CGFloat)width;

- (void)addSubNode:(VZFlexNode* )node;
- (void)removeSubNode:(VZFlexNode* )node;
- (void)removeSubNodeByName:(NSString* )name;


@end
