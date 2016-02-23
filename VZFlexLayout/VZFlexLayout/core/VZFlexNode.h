//
//  VZFlexNode.h
//  VZFlexLayout
//
//  Created by moxin on 15/12/25.
//  Copyright © 2015年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlexLayout.h"


typedef NS_OPTIONS(NSUInteger, VZFlexNodeDescriptionOption) {
    VZFlexNodeDescriptionOptionDefault = 0,
    VZFlexNodeDescriptionOptionHideResult = 1 << 0,
    VZFlexNodeDescriptionOptionHideUnspecified = 1 << 1,
    VZFlexNodeDescriptionOptionHideChildren = 1 << 2,
};

@interface VZFlexNode : NSObject

@property (nonatomic,assign,readonly) CGRect resultFrame;
@property (nonatomic,assign,readonly) UIEdgeInsets resultMargin;
@property (nonatomic,strong,readonly) NSArray* childNodes;

@property (nonatomic,copy) CGSize (^measure)(CGSize constraintedSize);
@property (nonatomic,strong)NSString* name;
@property (nonatomic,assign) FlexDirection direction;
@property (nonatomic,assign) FlexAlign alignItems;
@property (nonatomic,assign) FlexAlign alignSelf;
@property (nonatomic,assign) FlexAlign alignContent;
@property (nonatomic,assign) FlexAlign justifyContent;
@property (nonatomic,assign) CGFloat spacing;
@property (nonatomic,assign) CGFloat lineSpacing;
@property (nonatomic,assign) CGFloat flexBasis;
@property (nonatomic,assign) CGFloat flexGrow;
@property (nonatomic,assign) CGFloat flexShrink;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat minWidth;
@property (nonatomic,assign) CGFloat minHeight;
@property (nonatomic,assign) CGFloat maxWidth;
@property (nonatomic,assign) CGFloat maxHeight;
@property (nonatomic,assign) CGFloat margin;
@property (nonatomic,assign) CGFloat marginTop;
@property (nonatomic,assign) CGFloat marginLeft;
@property (nonatomic,assign) CGFloat marginBottom;
@property (nonatomic,assign) CGFloat marginRight;
@property (nonatomic,assign) CGFloat padding;
@property (nonatomic,assign) CGFloat paddingTop;
@property (nonatomic,assign) CGFloat paddingLeft;
@property (nonatomic,assign) CGFloat paddingBottom;
@property (nonatomic,assign) CGFloat paddingRight;
@property (nonatomic,assign) BOOL fixed;
@property (nonatomic,assign) BOOL wrap;

- (void)layout:(CGSize)constrainedSize;

- (void)addSubNode:(VZFlexNode* )node;
- (void)removeSubNode:(VZFlexNode* )node;

//for debugging
- (NSString *)recursiveDescription:(VZFlexNodeDescriptionOption)option;

@end
