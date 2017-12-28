//
//  Student.m
//  KVCLearn
//
//  Created by zhiyu.zhao on 16/9/2.
//  Copyright © 2016年 BJF. All rights reserved.
//

#import "Student.h"
#import <objc/runtime.h>

@interface Student ()
@property (nonatomic,assign,readwrite) BOOL readonly;

@end

@implementation Student

@synthesize mark = abc;
@synthesize readonly = _readonly;

-(void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

- (void)setFirstName:(NSString *)firstName {
    NSLog(@"重写的setFirstName方法");
//    [self test];
}

- (void)test {
    NSLog(@"start test current thread = %@", [NSThread currentThread]);
    self.readonly = YES;
    for (int i = 0;i < 100000;i++) {
        ;
    }
    NSLog(@"end test%s",__FUNCTION__);
}
- (void)setReadonly:(BOOL)readonly{
    _readonly = readonly;
    NSLog(@"改readonly为readwrite%s",__FUNCTION__);
}

- (void)setLoveFood:(NSString *)food {
    NSLog(@"调用了lovefood set方法");
    loveFood = food;
}

- (NSString *)loveFood {
    NSLog(@"调用了lovefood get方法");
    return loveFood;
}

+ (BOOL) automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"lovefood"]) {
        return NO;
    }
    
    return [super automaticallyNotifiesObserversForKey:key];
}


- (void)setMark:(NSString *)newMark {
    abc = newMark;
}

- (NSString *)mark {
    
    return abc;
}

- (NSString*)debugDescription {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSUInteger count = 0;
    objc_property_t *prolist= class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t p = prolist[i];
        NSString *name = @(property_getName(p));
        id value = [self valueForKey:name]?:@"nil";
        [dic setObject:value forKey:name];
    }
    free(prolist);
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class],self,dic];
    
}

//- (id)copyWithZone:(nullable NSZone *)zone{
//    
//}


@end
