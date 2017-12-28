//
//  Student.h
//  KVCLearn
//
//  Created by zhiyu.zhao on 16/9/2.
//  Copyright © 2016年 BJF. All rights reserved.
//

#import "Person.h"

@interface Student : Person  {
    NSString *loveFood;
};

- (void)test;
@property (nonatomic, strong) NSString* mark;
@end
