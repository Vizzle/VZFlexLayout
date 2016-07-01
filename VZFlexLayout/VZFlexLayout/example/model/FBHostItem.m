//
//  FBHostItem.m
//  FBComponentListDemo
//
//  Created by moxin on 16/1/20.
//  Copyright © 2016年 VizLab. All rights reserved.
//

#import "FBHostItem.h"


/**
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
 @property(nonatomic,strong,readonly)NSString* replyContent;
 */
@implementation FBHostItem

+ (instancetype)newWithJSON:(NSDictionary* )json{

    FBHostItem* item        = [FBHostItem new];
    item -> _type           = json[@"type"];
    item -> _headIconURL    = json[@"icon"];
    item -> _nick           = json[@"nick"];
    item -> _time           = json[@"time"];
    item -> _score          = json[@"score"];
    item -> _content        = json[@"content"];
    item -> _dishes         = json[@"dishes"];
    item -> _images         = json[@"images"];
    item -> _location       = json[@"location"];
    
    
    NSMutableArray* tmp = [NSMutableArray new];
    NSArray* cards = json[@"cards"];
    for (NSDictionary* card in cards) {
        FBScrollItem* scrollItem = [FBScrollItem new];
        scrollItem.imagePath = card[@"image"];
        scrollItem.name = card[@"name"];
        scrollItem.state = kDefault;
        [tmp addObject:scrollItem];
    }
    item -> _cards = [tmp copy];
    

    item -> _rewardCount       = json[@"rewardedCount"];
    item -> _likeCount         = json[@"likeCount"];
    item -> _commentCount      = json[@"commentCount"];
    
    
    item -> _rewardedPersons  = json[@"rewardedPersons"];
    item -> _likePersons      = json[@"likePersons"];
    item -> _comments         = json[@"comments"];
    
    
    item -> _isLike         = json[@"islike"];
    item -> _isComment      = json[@"iscomment"];
    item -> _isReward       = json[@"isReward"];
    
    item -> _iconTextBlockDict = json[@"iconTextBlock"];
    
    return  item;

}



@end


@implementation FBScrollItem



@end
