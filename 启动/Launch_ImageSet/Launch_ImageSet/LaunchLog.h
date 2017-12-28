//
//  LaunchLog.h
//  EmptyForTest
//
//  Created by baidu on 2017/10/23.
//  Copyright © 2017年 gamin. All rights reserved.
//

#import <Foundation/Foundation.h>

//static uint64_t preMainTime = -1;


@interface LaunchLog : NSObject
@property (nonatomic,assign)uint64_t preMainTime;

+ (instancetype)sharedInstance;
@end
