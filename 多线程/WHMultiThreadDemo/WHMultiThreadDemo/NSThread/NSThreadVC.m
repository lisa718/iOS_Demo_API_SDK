//
//  NSThreadVC.m
//  WHMultiThreadDemo
//  https://github.com/remember17/WHMultiThreadDemo
//  Created by 吴浩 on 2017/7/6.
//  Copyright © 2017年 wuhao. All rights reserved.
//  http://www.jianshu.com/p/7649fad15cdb

#import "NSThreadVC.h"
#import "TestTread.h"

@implementation NSThreadVC

- (IBAction)createNSThread1:(id)sender {
    /** 方法一，需要start */
    TestTread *thread1 = [[TestTread alloc] initWithTarget:self selector:@selector(doSomething1:) object:@"NSThread1"];
    // 线程加入线程池等待CPU调度，时间很快，几乎是立刻执行
    [thread1 start];
    NSLog(@"--------");
    [self performSelector:@selector(doSomething2:) onThread:thread1 withObject:@"In doSomething1" waitUntilDone:NO];
}

- (IBAction)createNSThread2:(id)sender {
    /** 方法二，创建好之后自动启动 */
    [NSThread detachNewThreadSelector:@selector(doSomething2:) toTarget:self withObject:@"NSThread2"];
}

- (IBAction)createNSThread3:(id)sender {
    /** 方法三，隐式创建，直接启动 */
    [self performSelectorInBackground:@selector(doSomething3:) withObject:@"NSThread3"];
    NSLog(@"--------");
}

- (void)doSomething1:(NSObject *)object {
    // 传递过来的参数
    NSLog(@"doSomething1参数：%@， 线程：%@",object,[NSThread currentThread]);
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    [loop run];
    NSLog(@"loop = %@",loop);
    
    

}

- (void)doSomething2:(NSObject *)object {
    NSLog(@"doSomething2参数：%@， 线程：%@",object,[NSThread currentThread]);
}

- (void)doSomething3:(NSObject *)object {
    NSLog(@"doSomething3参数：%@， 线程：%@",object,[NSThread currentThread]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSThread";
}

@end
