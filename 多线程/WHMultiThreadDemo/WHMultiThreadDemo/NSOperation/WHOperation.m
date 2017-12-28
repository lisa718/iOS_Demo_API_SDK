//
//  WHOperation.m
//  WHMultiThreadDemo
//  https://github.com/remember17/WHMultiThreadDemo
//  Created by 吴浩 on 2017/7/6.
//  Copyright © 2017年 wuhao. All rights reserved.
//  http://www.jianshu.com/p/7649fad15cdb

#import "WHOperation.h"

@interface WHOperation ()

@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;
@property (nonatomic,assign,getter=isCancelled) BOOL cancelled;

@end



@implementation WHOperation

@synthesize executing = _executing;
@synthesize finished = _finished;
@synthesize cancelled = _cancelled;

//- (void)main {
//    @try {
////        if (self.isCancelled) return;
//
//        NSLog(@"Start executing %@ with data: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), self.oname, [NSThread mainThread], [NSThread currentThread]);
//
//        for (NSUInteger i = 0; i < 3; i++) {
////            if (self.isCancelled) return;
//
//            sleep(1);
//
//            NSLog(@"Loop %@", @(i + 1));
//        }
//
//        NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
//    }
//    @catch(NSException *exception) {
//        NSLog(@"Exception: %@", exception);
//    }
//}

- (void)start {
    @synchronized(self) {
    self.executing = YES;
    for (int i = 0; i <= 10000000; i++) {
        ;
    }
    self.finished = YES;
    if (self.isCancelled) {
        self.finished = YES;
        self.executing = NO;
        NSLog(@"%@ is cancel when running",self.oname);
    }
    for (int i = 0; i < 3; i++) {
        NSLog(@"NSOperation的子类WHOperation======%@,%@",[NSThread currentThread],self.oname);
    }
    self.finished = YES;
    }
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}


- (void)setCancelled:(BOOL)cancelled{
    [self willChangeValueForKey:@"isCancelled"];
    _cancelled = cancelled;
    [self didChangeValueForKey:@"isCancelled"];
}


- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)cancel {
    [super cancel];
    self.cancelled = YES;
}

@end
