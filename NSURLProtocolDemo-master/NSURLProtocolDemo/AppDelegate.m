//
//  AppDelegate.m
//  NSURLProtocolDemo
//
//  Created by 陈爱彬 on 16/4/22.
//  Copyright © 2016年 陈爱彬. All rights reserved.
//

#import "AppDelegate.h"
#import "CCHTTPProtocol.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#warning 配置开发环境,这里仅添加两种，可以更换或添加自己项目中的环境
    NSDictionary *serverDict = @{@"production": @{@"host": @"api.flashdiet.cn",
                                                  @"port":@"8080"},
                                 @"dev": @{@"ip": @"47.94.203.22",
                                           @"port":@"8080"}};
    [[NSUserDefaults standardUserDefaults] setValue:serverDict forKey:@"ccServerInfo"];
    NSString *currentServer = [[NSUserDefaults standardUserDefaults] valueForKey:@"currentServer"];
    if (!currentServer || ![currentServer length]) {
        //默认保存正式环境
        [[NSUserDefaults standardUserDefaults] setValue:@"production" forKey:@"currentServer"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    //注册URLProtocol
    [NSURLProtocol registerClass:[CCHTTPProtocol class]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
