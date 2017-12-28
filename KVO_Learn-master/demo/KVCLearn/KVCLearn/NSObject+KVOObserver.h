//
//  NSObject+KVOObserver.h
//  KVCLearn
//
//  Created by baidu on 2017/9/11.
//  Copyright © 2017年 BJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVOObserverManager.h"

@interface NSObject (KVOObserver)

@property(nonatomic,strong) KVOObserverManager *KVO;

- (instancetype)initWithObserver:(id)observer;

@end
