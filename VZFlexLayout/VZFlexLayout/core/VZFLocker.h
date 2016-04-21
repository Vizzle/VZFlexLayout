
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


/**
 For use with VZ::StaticMutex only.
 */
#define VZ_MUTEX_INITIALIZER {PTHREAD_MUTEX_INITIALIZER}
#define VZ_MUTEX_RECURSIVE_INITIALIZER {PTHREAD_RECURSIVE_MUTEX_INITIALIZER}

// This MUST always execute, even when assertions are disabled. Otherwise all lock operations become no-ops!
// (To be explicit, do not turn this into an CKAssert, NSAssert, assert(), or any other kind of statement where the
// evaluation of x_ can be compiled out.)
#define VZ_THREAD_ASSERT_ON_ERROR(x_) do { \
_Pragma("clang diagnostic push"); \
_Pragma("clang diagnostic ignored \"-Wunused-variable\""); \
volatile int res = (x_); \
NSCAssert(res == 0, @" %@ returned %d",@#x_, res)\
_Pragma("clang diagnostic pop"); \
} while (0)

namespace VZ {
    
    template<typename T>
    class Locker{
        T &_l;
    public:
        Locker(T &l):_l(l){
            _l.lock();
        }
        ~Locker(){
            _l.unlock();
        }
        
        Locker(const Locker<T>&) = delete;
        Locker &operator=(const Locker<T>&) = delete;
    };
    
    struct Mutex{
        
        Mutex():Mutex(false){}
        
        ~Mutex () {
            VZ_THREAD_ASSERT_ON_ERROR(pthread_mutex_destroy (&_m));
        }
        
        Mutex (const Mutex&) = delete;
        Mutex &operator=(const Mutex&) = delete;
        
        void lock () {
            VZ_THREAD_ASSERT_ON_ERROR(pthread_mutex_lock (this->mutex()));
        }
        
        void unlock () {
            VZ_THREAD_ASSERT_ON_ERROR(pthread_mutex_unlock (this->mutex()));
        }
        
        pthread_mutex_t *mutex () { return &_m; }
    
        
    protected:
        explicit Mutex(bool recursive){
            if(!recursive){
                VZ_THREAD_ASSERT_ON_ERROR(pthread_mutex_init(&_m,NULL));
            }
            else{
                //recursive lock
                pthread_mutexattr_t attr;
                VZ_THREAD_ASSERT_ON_ERROR(pthread_mutexattr_init (&attr));
                VZ_THREAD_ASSERT_ON_ERROR(pthread_mutexattr_settype (&attr, PTHREAD_MUTEX_RECURSIVE));
                VZ_THREAD_ASSERT_ON_ERROR(pthread_mutex_init (&_m, &attr));
                VZ_THREAD_ASSERT_ON_ERROR(pthread_mutexattr_destroy (&attr));
            
            }
        }
        
    private:
        pthread_mutex_t _m;
        
    };
    typedef Locker<Mutex> MutexLocker;
    
    
    struct StaticMutex{
        
        pthread_mutex_t _m;
        
        
        void lock () {
            VZ_THREAD_ASSERT_ON_ERROR(pthread_mutex_lock (this->mutex()));
        }
        
        void unlock () {
            VZ_THREAD_ASSERT_ON_ERROR(pthread_mutex_unlock (this->mutex()));
        }
        pthread_mutex_t *mutex () { return &_m; }
        
        StaticMutex(const StaticMutex&) = delete;
        StaticMutex &operator=(const StaticMutex&) = delete;
    };
    
    typedef Locker<StaticMutex>StaticMutexLocker;
}


#endif /* VZFLocker_h */
