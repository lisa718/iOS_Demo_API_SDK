//
//  KVOObserverManager.h
//  KVCLearn
//
//  Created by baidu on 2017/9/11.
//  Copyright © 2017年 BJF. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ObserverNotifyBlock)(NSDictionary<NSKeyValueChangeKey, id>  *change);

@interface KVOObserverManager : NSObject

// 对外API方法：
- (void)observe:(NSObject*)observe
        keyPath:(NSString*)keyPath
        options:(NSKeyValueObservingOptions)option
          block:(ObserverNotifyBlock)block;

// 移除注册
- (void)unobserve:(NSObject*)observe keyPath:(NSString*)keyPath;
//- (void)unobserve:(NSObject*)observe;
- (void)unobserveAll;

@end
