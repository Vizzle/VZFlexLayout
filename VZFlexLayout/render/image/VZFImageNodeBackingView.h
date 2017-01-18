//
//  VZFImageNodeBackingView.h
//  VZFlexLayout-Example
//
//  Created by pep on 2017/1/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeBackingViewInterface.h"
#import "VZFNetworkImageDownloadProtocol.h"

@class VZFImageNodeRenderer;

@interface VZFImageNodeBackingView : UIImageView<VZFNodeBackingViewInterface, VZFNetworkImageDownloadProtocol>

@property(nonatomic,strong) VZFImageNodeRenderer* imageRenderer;

@end
