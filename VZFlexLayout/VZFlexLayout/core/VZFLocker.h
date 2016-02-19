
//
//  VZFLocker.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#ifndef VZFLocker_h
#define VZFLocker_h

#import <stdlib.h>
#import <pthread.h>
#import <libkern/OSAtomic.h>

namespace VZ {
    
    template<typename T>
    class Locker{
        T &_l;
    public:
        Locker(T &l):_l(l){}{
            _l.lock();
        }
        ~Locker(){
            _l.unlock();
        }
        
        Locker(const Locker<T>&) = delete;
        Locker &operator=(const Locker<T>&) = delete;
    };
    
    struct Mutex{
    
        
    };
    typedef Locker<Mutex> MutexLaocker;
    
    
    struct StaticMutex{
        
        pthread_mutext_t _m;
    
    };
}


#endif /* VZFLocker_h */
