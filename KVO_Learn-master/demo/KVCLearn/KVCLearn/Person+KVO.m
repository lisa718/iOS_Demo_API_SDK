//
//  Person+KVO.m
//  KVCLearn
//
//  Created by baidu on 2017/9/6.
//  Copyright © 2017年 BJF. All rights reserved.
//

#import "Person+KVO.h"
#import <objc/runtime.h>

@implementation Person (KVO)

- (void)test:(PersonKvoObserver*)personKvoObserver {
    
 
    [personKvoObserver addObserverForKeyPath:NSStringFromSelector(@selector(fullName))];  // 只读属性
//    [self addObserver:personKvoObserver forKeyPath:NSStringFromSelector(@selector(firstName)) options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:(__bridge void *)personKvoObserver];

}
- (NSString *)kvoperson_property{
    return objc_getAssociatedObject(self, _cmd);

}

- (void)setKvoperson_property:(NSString *)kvoperson_property{
     objc_setAssociatedObject(self, (__bridge const void *)(NSStringFromSelector(_cmd)),kvoperson_property , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
