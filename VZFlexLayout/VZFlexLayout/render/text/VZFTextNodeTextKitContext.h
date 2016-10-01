//
//  VZFTextNodeTextKitContext.h
//  VZFlexLayout
//
//  Created by moxin on 16/9/21.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VZFTextNodeTextKitContext : NSObject

@property(nonatomic,strong,readonly)NSLayoutManager* layoutManager;
@property(nonatomic,strong,readonly)NSTextStorage* textStorage;
@property(nonatomic,strong,readonly)NSTextContainer* textContainer;

- (instancetype)initWithAttributedString:(NSAttributedString* )attributedString
                           lineBreakMode:(NSLineBreakMode)lineBreakMode
                    maximumNumberOfLines:(NSUInteger)maximumNumberOfLines
                         constrainedSize:(CGSize)constrainedSize;

- (void)performTextOperation:(void (^)(NSLayoutManager *,
                                       NSTextStorage *,
                                       NSTextContainer *))block;

@end
