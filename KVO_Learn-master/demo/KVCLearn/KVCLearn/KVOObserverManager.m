//
//  KVOObserverManager.m
//  KVCLearn
//
//  Created by baidu on 2017/9/11.
//  Copyright © 2017年 BJF. All rights reserved.
//

#import "KVOObserverManager.h"
#import <objc/runtime.h>

@interface KVOObserveInfo : NSObject

@property (nonatomic,copy) ObserverNotifyBlock block;
@property (nonatomic,copy) NSString * keyPath;
@property (nonatomic,weak) KVOObserverManager *kvoManager;

@end

@implementation KVOObserveInfo

- (NSUInteger)hash{
    return [self.keyPath hash];
}

- (BOOL)isEqual:(id)object{
    if (nil == object) {
        return NO;
    }
    if (self == object) {
        return YES;
    }
    
    if (![self isKindOfClass:object]) {
        return NO;
    }
    
    return [self.keyPath isEqualToString:((KVOObserveInfo*)object).keyPath];
    
}
- (NSString *)debugDescription{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    //得到当前class的所有属性
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    //循环并用KVC得到每个属性的值
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:@"nil";
        //默认值为nil字符串
        [dictionary setObject:value forKey:name];//装载到字典里
    }    //释放
    free(properties);
    //return
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class],self,dictionary];

}
@end

//---------------------------------------------------
@interface KVOObserverManager()

// 也可以weak引用对象哦
@property (nonatomic,strong) NSMapTable<id,NSMutableSet<KVOObserveInfo*> *> *observeDic;
//@property (nonatomic,strong) NSMutableDictionary<id,NSMutableSet<KVOObserveInfo*> *> *observeDic;
@property (nonatomic,weak)id observer;

@end


@implementation KVOObserverManager

#pragma mark - life

- (instancetype)initWithObserver:(id)observer{
    self = [super init];
    if (nil != self) {
        self.observeDic = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory|NSPointerFunctionsObjectPersonality valueOptions:(NSPointerFunctionsStrongMemory | NSPointerFunctionsObjectPersonality) capacity:0];
//        self.observeDic = [NSMutableDictionary dictionary];
        self.observer = observer;
    }
    return self;
}

- (void)dealloc{
    
    [self unobserveAll];
    NSLog(@"%s",__FUNCTION__);
    
}

#pragma mark - API

// 对外API方法：
- (void)observe:(NSObject*)observe
        keyPath:(NSString*)keyPath
        options:(NSKeyValueObservingOptions)option
          block:(ObserverNotifyBlock)block{
    
    // 由于可以覆盖掉旧的值，所以不用判断是否有原值
    KVOObserveInfo *info = [[KVOObserveInfo alloc] init];
    info.keyPath = keyPath;
    info.block = block;
//    info.kvoManager = self;
    
    NSMutableSet *infosets = [self.observeDic objectForKey:observe];

    if ([infosets containsObject:info]) {
        return;
    }
    if (infosets == nil) {
        infosets = [NSMutableSet set];
    }
    [infosets addObject:info];
    [self.observeDic setObject:infosets forKey:observe];
    [observe addObserver:self forKeyPath:keyPath options:option context:(__bridge void *)info];
    
}

// 移除注册
- (void)unobserve:(NSObject*)observe keyPath:(NSString*)keyPath{
    
//    [observe removeObserver:self forKeyPath:keyPath];
    
}

- (void)unobserveAll{
    
    for (id key in self.observeDic.keyEnumerator) {
        NSMutableSet *set = [self.observeDic objectForKey:key];
        [set enumerateObjectsUsingBlock:^(KVOObserveInfo * obj, BOOL * _Nonnull stop) {
            [key removeObserver:self forKeyPath:obj.keyPath];
        }];
    }
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
//    if (context == (__bridge void *)self) {
    
        if (self.observer != nil)
        {
            NSMutableSet *infosets = [self.observeDic objectForKey:object];
            KVOObserveInfo *info = [infosets member:(__bridge id)context];
            if (info != nil && info.block!=nil) {
                info.block(change);
            }

        }
        
//    }
//    else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
    
}

@end
