//
//  VZFlexNode.h
//  VZFlexLayout
//
//  Created by moxin on 15/12/25.
//  Copyright © 2015年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,VZFlexValue)
{
    VZFLEX_UNDEFINED = -999999,
    VZFLEX_INFINITE  = -999998,
    VZFLEX_AUTO = -999997
};


typedef NS_ENUM(NSUInteger,VZFlexNodeDirection){
    
    VZFLEX_DIRECTION_HORIZONTAL = 0,
    VZFLEX_DIRECTION_VERTICAL = 1
};

typedef NS_ENUM(NSUInteger,VZFlexNodeAlignItems)
{
    VZFLEX_ALIGN_ITEMS_START,
    VZFLEX_ALIGN_ITEMS_END,
    VZFLEX_ALIGN_ITEMS_CENTER,
    VZFLEX_ALIGN_ITEMS_STRETCH
};

typedef NS_ENUM(NSUInteger,VZFlexNodeAlignSelf)
{
    VZFLEX_ALIGN_SELF_AUTO = 0,
    VZFLEX_ALIGN_SELF_START,
    VZFLEX_ALIGN_SELF_CENTER,
    VZFLEX_ALIGN_SELF_END,
    VZFLEX_ALIGN_SELF_STRETCH
};
typedef NS_ENUM(NSUInteger,VZFlexNodeAlignContent)
{
    VZFLEX_ALIGN_CONTENT_START=0,
    VZFLEX_ALIGN_CONTENT_CENTER,
    VZFLEX_ALIGN_CONTENT_END,
    VZFLEX_ALIGN_CONTENT_STRETCH
};

typedef NS_ENUM(NSUInteger,VZFlexNodeJustifyContent)
{
    VZFLEX_JC_START = 0,
    VZFLEX_JC_END,
    VZFLEX_JC_CENTER,
    VZFLEX_JC_SPACE_BETWEEN
};



typedef CGFloat VZFlexNodeFlexValue;

@interface VZFlexNode : NSObject

//@property (nonatomic,strong,readonly) UIView* view;
@property (nonatomic,assign,readonly) CGRect frame;
@property (nonatomic,strong,readonly) NSArray* childNodes;
//to be done
@property (nonatomic, copy) CGSize (^measureBlock)(CGFloat width);

@property (nonatomic,strong)NSString* name;
@property (nonatomic,assign)BOOL wrap;
@property (nonatomic,assign)BOOL fixed;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGSize minSize;
@property (nonatomic,assign)CGSize maxSize;
@property (nonatomic,assign)UIEdgeInsets margin;
@property (nonatomic,assign)UIEdgeInsets padding;
@property (nonatomic,assign)VZFlexNodeDirection flexDirection;
@property (nonatomic,assign)VZFlexNodeAlignItems alignItems;
@property (nonatomic,assign)VZFlexNodeAlignSelf alignSelf;
@property (nonatomic,assign)VZFlexNodeAlignContent alignContent;
@property (nonatomic,assign)VZFlexNodeJustifyContent justifyContent;
@property (nonatomic,assign)VZFlexNodeFlexValue flexGrow;
@property (nonatomic,assign)VZFlexNodeFlexValue flexShrink;

- (void)layout:(CGSize)constrainedSize;
- (CGSize)sizeThatFits:(CGSize)constraintedSize;
- (void)renderRecursively;//for test only
- (void)addSubNode:(VZFlexNode* )node;
- (void)removeSubNode:(VZFlexNode* )node;


@end
