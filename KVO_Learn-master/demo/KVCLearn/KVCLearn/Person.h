//
//  Person.h
//  KVCLearn
//
//  Created by zhiyu.zhao on 16/9/2.
//  Copyright © 2016年 BJF. All rights reserved.
//

#import <Foundation/Foundation.h>
static int i = 0;

@interface Person : NSObject
@property (nonatomic, copy) NSString *firstName;
@property (atomic, strong) NSString *lastName;
@property (nonatomic, strong, readonly) NSString *fullName;
@property (nonatomic,readonly,assign) BOOL readonly;

@property (nonatomic, strong) Person *father;
@property (nonatomic, copy) NSArray<Person *> *friends;
@property (nonatomic, strong) NSMutableArray<Person *> *mutiFriends;

- (void)setNewInnerName:(NSString *)str;
- (void)changeAge:(int)age;
//- (NSUInteger)countOfMutiFriends;

@end
