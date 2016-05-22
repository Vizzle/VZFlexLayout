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
#import "VZFMacros.h"
#import "VZFNodeBackingViewInterface.h"

@implementation VZFViewReusePool
{
    std::vector<UIView* > _reusePool;
    std::vector<UIView* >::iterator _nextUsableViewPos;
    
    unsigned long _debug_index;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _nextUsableViewPos = _reusePool.begin();
        _debug_index = 0;
    }
    return self;
}
- (UIView* )viewForClass:(const ViewClass&)viewClass ParentView:(UIView* )container{
    
    UIView* v = nil;
    if (_nextUsableViewPos == _reusePool.end()) {
        //push a new one
        v = viewClass.createView();
        
        if (v) {
            if (container) {
                [container addSubview:v];
                
            }
 
            _reusePool.push_back(v);
            _nextUsableViewPos = _reusePool.end();
 
            VZ::Mounting::createView(v);
            NSLog(@"[%@]-->create_view:<%@,%p> | status:{reusePoolSize:%ld}",self.class,v.class,v, _reusePool.size());
            _debug_index = _reusePool.size()-1;
        }
    }
    else{
        //return an existing one
         v = *_nextUsableViewPos;
         VZ::Mounting::prepareForReuse(v);
         NSLog(@"[%@]-->recycle_view:<%@,%p,index:%ld>",self.class,v.class,v,_debug_index);
        _nextUsableViewPos ++;
        _debug_index ++;
    }
    return v;

}
- (void)reset{

    NSLog(@"%s",__PRETTY_FUNCTION__);
    unsigned long i=0;
    for(auto itor = _reusePool.begin(); itor != _nextUsableViewPos; ++itor){
        
        UIView* view = *itor;
        VZ::Mounting::unhide(view);
        [view setHidden:NO];
        NSLog(@"[%@]-->show:<%@,%p|index:%ld>",self.class,view.class,view,i);
        i++;
        
    }
    for(auto itor = _nextUsableViewPos; itor != _reusePool.end(); ++itor){
        UIView* view = *itor;
        VZ::Mounting::hide(view);
        [view setHidden:YES];
        NSLog(@"[%@]-->hide:<%@,%p|index:%ld>",self.class,view.class,view,i);
        i++;
    }
    _nextUsableViewPos = _reusePool.begin();
}

@end
