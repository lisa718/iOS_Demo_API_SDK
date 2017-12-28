//
//  LaunchLog.m
//  EmptyForTest
//
//  Created by baidu on 2017/10/23.
//  Copyright © 2017年 gamin. All rights reserved.
//

#import "LaunchLog.h"
#import <mach/mach_time.h>


@import UIKit;

static uint64_t loadTime;
static uint64_t applicationRespondedTime = -1;
//static NSTimeInterval loadTime = -1;
//static NSTimeInterval applicationRespondedTime = -1;
static mach_timebase_info_data_t timebaseInfo;
//static id observer1;

static inline NSTimeInterval MachTimeToSeconds(uint64_t machTime) {
    return ((machTime / 1e9) * timebaseInfo.numer) / timebaseInfo.denom;
}

@implementation LaunchLog
- (instancetype)init {
    self = [super init];
    if (self != nil) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:(UIApplicationWillResignActiveNotification) object:nil];
        });
    }
    
    return self;
}

+ (void)load {
    loadTime = mach_absolute_time();
//    loadTime = CFAbsoluteTimeGetCurrent();
    mach_timebase_info(&timebaseInfo);
    NSLog(@"current thread %@",[NSThread currentThread]);
    @autoreleasepool {
        __block id obs;

        obs = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification
                                                                object:nil
                                                                 queue:nil
                                                            usingBlock:^(NSNotification *note) {
                                                                dispatch_async(dispatch_get_main_queue(), ^{
//                                                                    applicationRespondedTime = CFAbsoluteTimeGetCurrent();
                                                                    applicationRespondedTime = mach_absolute_time();
//                                                                    NSLog(@"StartupMeasurer: it took %f seconds until the app could respond to user interaction.", MachTimeToSeconds(applicationRespondedTime - loadTime));
                                                                });
                                                                [[NSNotificationCenter defaultCenter] removeObserver:obs];
                                                                
                                                            }];
        
        
//        __block id obs1;
//        obs1 = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:[NSOperationQueue ] usingBlock:^(NSNotification * _Nonnull note) {
//
//            [[NSUserDefaults standardUserDefaults] setObject:@(preMaintTime-loadTime) forKey:@"time_premain"];
//            [[NSUserDefaults standardUserDefaults] setObject:@(applicationRespondedTime-loadTime) forKey:@""];
//
//            [[NSNotificationCenter defaultCenter] removeObserver:obs1];
//
//        }];
    }
}


- (void)save {
    [[NSUserDefaults standardUserDefaults] setObject:@(MachTimeToSeconds(self.preMainTime-loadTime)) forKey:@"time_premain"];
    [[NSUserDefaults standardUserDefaults] setObject:@(MachTimeToSeconds(applicationRespondedTime-loadTime)) forKey:@"main_time"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

+ (instancetype)sharedInstance {
    static LaunchLog *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LaunchLog new];
    });
    return instance;
}

@end
