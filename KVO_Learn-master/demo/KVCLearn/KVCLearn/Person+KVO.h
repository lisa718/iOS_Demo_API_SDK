//
//  Person+KVO.h
//  KVCLearn
//
//  Created by baidu on 2017/9/6.
//  Copyright © 2017年 BJF. All rights reserved.
//

#import "Person.h"
#import "PersonKvoObserver.h"

@interface Person (KVO)

- (void)test:(PersonKvoObserver*)personKvoObserver;
@property (nonatomic,strong)NSString *kvoperson_property;
@end
