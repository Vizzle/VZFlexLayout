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
        _textRenderer.maxSize = CGSizeMake(MAX(size.width -image.size.width ,0),size.height);
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
    // avoid being dealloced
    VZFImageNodeRenderer *backgroundImageRenderer = _backgroundImageRenderer;
    VZFImageNodeRenderer *imageRenderer = _imageRenderer;
    VZFTextNodeRenderer *textRenderer =  _textRenderer;

    if (backgroundImageRenderer) {
        [backgroundImageRenderer drawInContext:context bounds:bounds];
    }
    CGFloat w = MIN(imageRenderer.image.size.width + textRenderer.textSize.width,CGRectGetWidth(bounds));
    if(imageRenderer){
        [imageRenderer drawInContext:context bounds:CGRectMake( (CGRectGetWidth(bounds)-w)/2, 0, w - textRenderer.textSize.width, CGRectGetHeight(bounds))];
    }
    if (textRenderer) {
        [textRenderer drawInContext:context bounds:CGRectMake(
                                                               (CGRectGetWidth(bounds)+w)/2 - textRenderer.textSize.width,
                                                                (CGRectGetHeight(bounds)- textRenderer.textSize.height)/2,
                                                                textRenderer.textSize.width, textRenderer.textSize.height) ];
    }
}

@end
