//
//  VZFViewReusePool.m
//  O2OReact
//
//  Created by moxin on 16/3/25.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFViewReusePool.h"
#import "VZFUtils.h"
#import "VZFNodeViewClass.h"
#include <vector>
#include <string>
@implementation VZFViewReusePool
{
    std::vector<UIView* > _reusePool;
    std::vector<UIView* >::iterator _nextUsableViewPos;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _nextUsableViewPos = _reusePool.begin();
    }
    return self;
}

- (NSString* )description{

    
    NSMutableString* str = [[NSMutableString alloc]init];
    for( auto &it : _reusePool){
        [str appendString:it.description];
    }
    
    return [NSString stringWithFormat:@"[%@]-->{%@}",self.class,str];


}

- (UIView* )viewForClass:(const VZ::ViewClass&)viewClass ParentView:(UIView* )container{
    
    UIView* v = nil;
    if (_nextUsableViewPos == _reusePool.end()) {

        //push a new one
        v = viewClass.createView();
        if (container) {
            [container addSubview:v];
        }
        _reusePool.push_back(v);
        _nextUsableViewPos = _reusePool.end();
        VZ::Mounting::createView(v, viewClass, container);
        
        NSLog(@"[%@] --> Create:%@(%p)",[self class],[v class],v);
        
        
    }
    else{
        //return an existing one
         v = *_nextUsableViewPos;
        _nextUsableViewPos ++;
        NSLog(@"[%@] --> Recycle:%@(%p)",[self class],[v class],v);
    }
    
    NSLog(@"[%@]-->status:%@",[self class],self);
    return v;

}
- (void)reset{

    for(auto itor = _reusePool.begin(); itor != _nextUsableViewPos; ++itor){
        
        UIView* view = *itor;
        VZ::Mounting::unhide(view);
        [view setHidden:NO];
    }
    for(auto itor = _nextUsableViewPos; itor != _reusePool.end(); ++itor){
        UIView* view = *itor;
        VZ::Mounting::hide(view);
        [view setHidden:YES];
    }
    _nextUsableViewPos = _reusePool.begin();
}

@end
