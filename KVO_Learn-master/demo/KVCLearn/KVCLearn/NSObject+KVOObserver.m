//
//  NSObject+KVOObserver.m
//  KVCLearn
//
//  Created by baidu on 2017/9/11.
//  Copyright © 2017年 BJF. All rights reserved.
//

#import "NSObject+KVOObserver.h"
#import <objc/runtime.h>

@implementation NSObject (KVOObserver)

- (void)setKVO:(KVOObserverManager *)KVO{
    objc_setAssociatedObject(self, (__bridge const void *)(NSStringFromSelector(_cmd)), KVO, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (KVOObserverManager*)KVO{
    id kvo = objc_getAssociatedObject(self, _cmd);
    if (kvo == nil) {
        kvo = [[KVOObserverManager alloc] initWithObserver:self];
        self.KVO = kvo;
    }

    return kvo;
}

@end
