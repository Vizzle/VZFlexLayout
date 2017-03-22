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

/**
 *  Objective-C wrapper of FlexLayout
 */
@interface VZFlexNode : NSObject

@property (nonatomic,assign,readonly) CGRect resultFrame;
@property (nonatomic,assign,readonly) UIEdgeInsets resultMargin;
@property (nonatomic,assign,readonly) UIEdgeInsets resultPadding;
@property (nonatomic,strong,readonly) NSArray* childNodes;

@property (nonatomic,copy) CGSize (^measure)(CGSize constrainedSize);
@property (nonatomic,copy) CGFloat (^baseline)(CGSize constrainedSize);
@property (nonatomic,strong)NSString* name;
@property (nonatomic,assign) FlexDirection direction;
@property (nonatomic,assign) FlexAlign alignItems;
@property (nonatomic,assign) FlexAlign alignSelf;
@property (nonatomic,assign) FlexAlign alignContent;
@property (nonatomic,assign) FlexAlign justifyContent;
@property (nonatomic,assign) FlexLength spacing;
@property (nonatomic,assign) FlexLength lineSpacing;
@property (nonatomic,assign) FlexLength flexBasis;
@property (nonatomic,assign) CGFloat flexGrow;
@property (nonatomic,assign) CGFloat flexShrink;
@property (nonatomic,assign) FlexLength width;
@property (nonatomic,assign) FlexLength height;
@property (nonatomic,assign) FlexLength minWidth;
@property (nonatomic,assign) FlexLength minHeight;
@property (nonatomic,assign) FlexLength maxWidth;
@property (nonatomic,assign) FlexLength maxHeight;
@property (nonatomic,assign) FlexLength margin;
@property (nonatomic,assign) FlexLength marginTop;
@property (nonatomic,assign) FlexLength marginLeft;
@property (nonatomic,assign) FlexLength marginBottom;
@property (nonatomic,assign) FlexLength marginRight;
@property (nonatomic,assign) FlexLength padding;
@property (nonatomic,assign) FlexLength paddingTop;
@property (nonatomic,assign) FlexLength paddingLeft;
@property (nonatomic,assign) FlexLength paddingBottom;
@property (nonatomic,assign) FlexLength paddingRight;
@property (nonatomic,assign) BOOL fixed;
@property (nonatomic,assign) FlexWrapMode wrap;
@property (nonatomic,assign) unsigned int lines;
@property (nonatomic,assign) unsigned int itemsPerLine;

- (void)layout:(CGSize)constrainedSize;

- (void)addSubNode:(VZFlexNode* )node;
- (void)removeSubNode:(VZFlexNode* )node;

//for debugging
- (NSString *)recursiveDescription:(VZFlexNodeDescriptionOption)option;

@end
