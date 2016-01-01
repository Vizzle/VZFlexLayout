
#pragma once

#include "Macros.h"

namespace flex {
    
    class Node {
    public:
        virtual ~Node() {}
        virtual Size sizeThatFits(Size constraitedSize) const {
            return {0, 0};
        }
        virtual OSView* createView() const = 0;
        virtual std::shared_ptr<Node> copy() const = 0;
    };
    
    template<class node>
    struct NodeCreator{
        static std::shared_ptr<Node> createNode(node n) {
            return std::make_shared<Node>();
        }
    };
    
#define REG_NODE(node, attr)                                \
    template<>                                              \
    struct NodeCreator<attr>{                               \
        static std::shared_ptr<Node> createNode(attr n) {   \
            return std::make_shared<node>(n);               \
        }                                                   \
    };

    struct NodeWraper {
        std::shared_ptr<Node> node;
        
        NodeWraper() : node(nullptr) {}
        NodeWraper(const NodeWraper& node) : node(node.node ? node.node->copy() : nullptr) {}
        virtual ~NodeWraper() {}
        
        NodeWraper& operator=(const NodeWraper& node) { this->node = node.node ? node.node->copy() : nullptr; return *this; }
        
        template<class T>
        NodeWraper(const T& node) {
            this->node = NodeCreator<T>::createNode(node);
        }
    };
    
}
