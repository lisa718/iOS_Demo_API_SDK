//
//  ViewController.m
//  SimpleRunLoop
//
//  Created by xianmingchen on 16/5/31.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "ViewController.h"
#import "NSThread+SimpleRunLoop.h"
#import "SimpleTimer.h"
@interface ViewController ()

@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIButton *button2;
@end

@implementation ViewController

static void runLoopOberverCallBack(CFRunLoopObserverRef observer,CFRunLoopActivity activity,void *info)
{

    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit");
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runLoopOberverCallBack, &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
    
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    
    NSLog(@"viewDidLoad begin");
    
    //create a input source
    SimpleTimer *timer = [SimpleTimer scheduledTimerWithTimerInterval:2 target:self selector:@selector(timerFire:) repeat:YES];
    
    //add input source to RunLoop
    SimpleRunLoop *simpleRunLoop = [NSThread currentSimpleRunLoop];
    [simpleRunLoop addTimer:timer];
    
    //begin the runloop
    [simpleRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]]; //run 10 second
    
    NSLog(@"viewDidLoad end");
}

- (void)timerFire:(NSTimer *)timer
{
    NSLog(@"timerFire begin");
    NSLog(@"timerFire end");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters & setters
- (UIButton *)button1
{
    if (_button1 == nil) {
        
        _button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _button1.frame = CGRectMake(100, 100, 100, 30);
        [_button1 addTarget:self action:@selector(one:) forControlEvents:UIControlEventTouchUpInside];
        [_button1 setTitle:@"One" forState:UIControlStateNormal];
    }
    return _button1;
}

- (UIButton *)button2
{
    if (_button2 == nil) {
        
        _button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _button2.frame = CGRectMake(100, 200, 100, 30);
        [_button2 addTarget:self action:@selector(two:) forControlEvents:UIControlEventTouchUpInside];
        [_button2 setTitle:@"Two" forState:UIControlStateNormal];
    }
    return _button2;
}

#pragma mark - actions
- (void)one:(UIButton*)sender
{
    NSLog(@"begin - (void)one:(UIButton*)sender");
    while (1) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    NSLog(@"end - (void)one:(UIButton*)sender");
}

- (void)two:(UIButton*)sender
{
    NSLog(@"- (void)two:(UIButton*)sender");
}
@end
