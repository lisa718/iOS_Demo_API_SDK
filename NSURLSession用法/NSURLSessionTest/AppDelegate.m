//
//  AppDelegate.m
//  NSURLSessionTest
//
//  Created by mdd on 16/2/22.
//  Copyright © 2016年 com.personal. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 获取远程推送消息
    NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        // 有推送的消息，处理推送的消息
    }
    
    return YES;
}
@end



