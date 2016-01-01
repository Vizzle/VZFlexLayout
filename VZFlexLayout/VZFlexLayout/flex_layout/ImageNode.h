
#pragma once

#include "Color.h"
#include "Node.h"
#include "Font.h"
#include "Image.h"

#include <string>

namespace flex {
    
#if FLEX_IOS
    using OSImageView = UIImageView;
#elif FLEX_OSX
    using OSImageView = NSImageView;
#endif
    
    enum class SizeMode {
        Stretch,
        Center,
        Zoom,
        Fill,
    };
    
    struct ImageNode {
        Image image;
        SizeMode sizeMode;
    };
    
    class ImageNodeClass : public Node, public ImageNode {
    public:
        ImageNodeClass() {}
        ImageNodeClass(ImageNode attrs) : ImageNode(attrs) {}
        
        virtual Size sizeThatFits(Size constraitedSize) const override {
            OSImage *image = this->image;
            if (image) {
                return {image.size.width, image.size.height};
            }
            
            return {0, 0};
        }
        
        virtual OSView* createView() const override {
            OSImageView *view = [[OSImageView alloc] init];
            view.image = image;
#if FLEX_IOS
            view.contentMode = sizeMode == SizeMode::Center ? UIViewContentModeCenter : sizeMode == SizeMode::Zoom ? UIViewContentModeScaleAspectFit : sizeMode == SizeMode::Fill ? UIViewContentModeScaleAspectFill : UIViewContentModeScaleToFill;
#elif FLEX_OSX
            view.imageScaling = sizeMode == SizeMode::Center ? NSImageScaleNone : sizeMode == SizeMode::Zoom ? NSImageScaleProportionallyUpOrDown : sizeMode == SizeMode::Fill ? NSImageScaleProportionallyDown : NSImageScaleAxesIndependently;
            view.imageAlignment = NSImageAlignCenter;
#endif
            return view;
        }
        
        virtual std::shared_ptr<Node> copy() const override {
            return std::make_shared<ImageNodeClass>(*this);
        }
        
    };
    
    REG_NODE(ImageNodeClass, ImageNode)
    
}
