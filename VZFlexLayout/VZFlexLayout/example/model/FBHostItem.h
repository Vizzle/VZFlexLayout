//
//  FBHostItem.h
//  FBComponentListDemo
//
//  Created by moxin on 16/1/20.
//  Copyright © 2016年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBHostItem : NSObject



@property(nonatomic,strong,readonly)NSString* headIconURL;
@property(nonatomic,strong,readonly)NSString* nick;
@property(nonatomic,strong,readonly)NSString* time;
@property(nonatomic,strong,readonly)NSString* score;
@property(nonatomic,strong,readonly)NSString* content;
@property(nonatomic,strong,readonly)NSArray<NSString* >* dishes;
@property(nonatomic,strong,readonly)NSArray<NSString* >* images;
@property(nonatomic,strong,readonly)NSString* location;
@property(nonatomic,strong,readonly)NSString* zanCount;
@property(nonatomic,strong,readonly)NSString* likeCount;
@property(nonatomic,strong,readonly)NSArray<NSString* >* zanPersons;
@property(nonatomic,strong,readonly)NSArray<NSString* >* likePersons;
@property(nonatomic,strong,readonly)NSString* comment;
@property(nonatomic,strong,readonly)NSString* replyContent;
@property(nonatomic,strong,readonly)NSString* isLike;
@property(nonatomic,strong,readonly)NSString* isComment;

+ (instancetype)newWithJSON:(NSDictionary* )json;


@end
