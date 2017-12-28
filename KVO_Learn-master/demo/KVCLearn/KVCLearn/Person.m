//
//  Person.m
//  KVCLearn
//
//  Created by zhiyu.zhao on 16/9/2.
//  Copyright © 2016年 BJF. All rights reserved.
//

#import "Person.h"
@interface Person ()
{
    int _age;
}
@property (nonatomic,strong) NSString *innerName;
@property (nonatomic,assign) int sex;
@end
@implementation Person

- (instancetype)init {
    if (self = [super init]) {
        _age = 18;
    }
    return self;
}
- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@%@",_firstName,_lastName];
//    return [NSString stringWithFormat:@"i=%d",i++];
}

- (void)setFirstName:(NSString *)firstName
{
    _firstName = firstName;
}


+ (NSSet *)keyPathsForValuesAffectingFullName
{
    return [NSSet setWithObjects:@"firstName",@"lastName", nil];
}

- (void)setNewInnerName:(NSString *)str {
//    self.innerName = str;// 通过get、set访问  触发KVO
//    [self setValue:str forKey:@"innerName"];// KVC方式,其实调用的也是setter方法 触发KVO
    _innerName = str;// 直接访问成员变量，不触发KVO
}

- (void)changeAge:(int)age{
    _age = 38;
    _sex = 10;
    _firstName = @"abc";
    
}

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);

}

//- (NSUInteger)countOfMutiFriends {
//    return [self.mutiFriends count];
//}

@end
