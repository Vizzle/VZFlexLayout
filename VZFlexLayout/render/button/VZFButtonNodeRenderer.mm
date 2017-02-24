//
//  VZFButtonNodeRenderer.m
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFButtonNodeRenderer.h"
#import "VZFTextNodeRenderer.h"
#import "VZFImageNodeRenderer.h"

@implementation VZFButtonNodeRenderer{
    NSMutableDictionary *_titleColorDic;
    NSMutableDictionary *_titleDic;
    
    NSMutableDictionary *_imageDic;
    NSMutableDictionary *_backgroundImageDic;
    
    VZFTextNodeRenderer *_textRenderer;
    VZFImageNodeRenderer *_imageRenderer;
    VZFImageNodeRenderer *_backgroundImageRenderer;
}

-(void)updateRenderer:(UIControlState)state maxSize:(CGSize)size scale:(CGFloat)sacle{
    UIColor *c= [_titleColorDic objectForKey:@(state)]?:[_titleColorDic objectForKey:@(UIControlStateNormal)];
    NSString *title = [_titleDic objectForKey:@(state)]?:[_titleDic objectForKey:@(UIControlStateNormal)];
    
    UIImage *image = [_imageDic objectForKey:@(state)]?:[_imageDic objectForKey:@(UIControlStateNormal)];
    UIImage *bgimage = [_backgroundImageDic objectForKey:@(state)]?:[_backgroundImageDic objectForKey:@(UIControlStateNormal)];

    if (image) {
        _imageRenderer = [VZFImageNodeRenderer new];
        _imageRenderer.contentMode = UIViewContentModeCenter;
        _imageRenderer.scale = sacle;
        _imageRenderer.image = image;
    }
    
    if (bgimage) {
        _backgroundImageRenderer = [VZFImageNodeRenderer new];
        _backgroundImageRenderer.contentMode = UIViewContentModeScaleToFill;
        _backgroundImageRenderer.scale = sacle;
        _backgroundImageRenderer.image = bgimage;
    }
    
    if (c && title) {
        _textRenderer = [VZFTextNodeRenderer new];
        _textRenderer.text = [[NSAttributedString new] initWithString:title attributes:@{NSFontAttributeName:self.titleFont?:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:c}];
        _textRenderer.truncatingMode = VZFTextTruncatingTail;
        _textRenderer.verticalAlignment = VZFTextVerticalAlignmentCenter;
        _textRenderer.alignment = NSTextAlignmentCenter;
        _textRenderer.maxNumberOfLines = 1;
        // TODO:与@胖砸确认
        _textRenderer.maxSize = CGSizeMake(MAX(size.width -image.size.width ,0), FLT_MAX);
    }

}

-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    if (!_titleColorDic) {
        _titleColorDic = [[NSMutableDictionary alloc] initWithCapacity:8];
    }
    if (color) {
        [_titleColorDic setObject:color forKey:@(state)];
    }else{
        [_titleColorDic removeObjectForKey:@(state)];
    }
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    if (!_titleDic) {
        _titleDic = [[NSMutableDictionary alloc] initWithCapacity:8];
    }
    if (title) {
        [_titleDic setObject:title forKey:@(state)];
    }else{
        [_titleDic removeObjectForKey:@(state)];
    }

}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    if (!_imageDic) {
        _imageDic = [[NSMutableDictionary alloc] initWithCapacity:8];
    }
    if (image) {
        [_imageDic setObject:image forKey:@(state)];
    }else{
        [_imageDic removeObjectForKey:@(state)];
    }
}

-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    if (!_backgroundImageDic) {
        _backgroundImageDic = [[NSMutableDictionary alloc] initWithCapacity:8];
    }
    if (image) {
        [_backgroundImageDic setObject:image forKey:@(state)];
    }else{
        [_backgroundImageDic removeObjectForKey:@(state)];
    }
}


- (void)drawContentInContext:(CGContextRef)context bounds:(CGRect)bounds {
    if (_backgroundImageRenderer) {
        [_backgroundImageRenderer drawInContext:context bounds:bounds];
    }
    CGFloat w = MIN(_imageRenderer.image.size.width + _textRenderer.textSize.width,CGRectGetWidth(bounds));
    if(_imageRenderer){
        [_imageRenderer drawInContext:context bounds:CGRectMake( (CGRectGetWidth(bounds)-w)/2, 0, w - _textRenderer.textSize.width, CGRectGetHeight(bounds))];
    }
    if (_textRenderer) {
        [_textRenderer drawInContext:context bounds:CGRectMake(
                                                               (CGRectGetWidth(bounds)+w)/2 - _textRenderer.textSize.width,
                                                                (CGRectGetHeight(bounds)- _textRenderer.textSize.height)/2,
                                                                _textRenderer.textSize.width, _textRenderer.textSize.height) ];
    }
}

@end
