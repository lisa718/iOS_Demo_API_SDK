//
//  main.m
//  Launch_ImageSet
//
//  Created by baidu on 2017/10/25.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LaunchLog.h"
#import <mach/mach_time.h>

int main(int argc, char * argv[]) {
    [LaunchLog sharedInstance].preMainTime = mach_absolute_time();
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
