//
//  VZFNetworkImageView.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNetworkImageDownloadProtocol.h"

@interface VZFNetworkImageView : UIImageView<VZFNetworkImageDownloadProtocol>

- (void)enterReusePool;
- (void)leaveReusePool;

@end
