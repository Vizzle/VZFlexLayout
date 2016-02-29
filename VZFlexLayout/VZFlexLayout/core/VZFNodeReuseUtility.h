//
//  VZFNodeReuseUtility.h
//  VZFlexLayout
//
//  Created by 俞伟平 on 2/26/16.
//  Copyright © 2016 Vizlab. All rights reserved.
//

#import <vector>

#import <UIKit/UIKit.h>

class VZFNodeViewClass;

namespace VZ {
    class ViewReuseUtilities {
    public:
        /** Called when Components will begin mounting in a root view */
        static void mountingInRootView(UIView *rootView);
        /** Called when Components creates a view */
        static void createdView(UIView *view, const VZFNodeViewClass &viewClass, UIView *parent);
        /** Called when Components will begin mounting child components in a new child view */
        static void mountingInChildContext(UIView *view, UIView *parent);
        
        /** Called when Components is about to hide a Components-managed view */
        static void didHide(UIView *view);
        /** Called when Components is about to unhide a Components-managed view */
        static void willUnhide(UIView *view);
    };
}

