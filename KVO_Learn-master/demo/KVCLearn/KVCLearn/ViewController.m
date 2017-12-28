//
//  ViewController.m
//  KVCLearn
//
//  Created by zhiyu.zhao on 16/9/2.
//  Copyright © 2016年 BJF. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "PersonKvoObserver.h"
#import "Student.h"
#import "StudentKvoObserver.h"
#import "Teacher.h"

#import "NSObject+KVOObserver.h"
#import "KVOObserverManager.h"

#import "NSObject+FBKVOController.h"
#import "FBKVOController.h"

#import <objc/runtime.h>

@interface ViewController ()
@property (nonatomic,strong) Student * stu;
@property (nonatomic,strong) StudentKvoObserver *stuObserver;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableString *mutableLastName = [@"abc" mutableCopy];
    Person *fp = [[Person alloc] init];
    fp.firstName = @"zhao";
    fp.lastName = @"laoda";
    
    Person *fri1 = [[Person alloc] init];
    fri1.firstName = @"wang";
    fri1.lastName = @"hao";
    
    Person *fri2 = [[Person alloc] init];
    fri2.firstName = @"chunge";
    fri2.lastName = mutableLastName;//@"li";

    Person *p = [[Person alloc] init];
    p.firstName = @"zhao";
    p.lastName = @"zhiyu";
    p.father = fp;
    p.friends = @[];
    p.mutiFriends = [@[fri1] mutableCopy];

    
    //------------------查看类的变化 ------------
    NSLog(@"Person self class original = %p",[p class]);
    NSLog(@"Person meta origianl = %p",object_getClass(object_getClass(p)));
    
    Person *p1 = [[Person alloc] init];
    NSLog(@"Person1 self class original = %p",[p1 class]);
    NSLog(@"Person1 meta origianl = %p",object_getClass(object_getClass(p1)));
    
//    Student *stu = [[Student alloc] init];
//    object_setClass(p, [Student class]);
    
    PersonKvoObserver *personKvoObserver = [[PersonKvoObserver alloc] initWithPerson:p];
//    [p performSelector:@selector(test:) withObject:personKvoObserver];


    [personKvoObserver addObserverForKeyPath:@"sex"];  // 成员变量

    [personKvoObserver addObserverForKeyPath:NSStringFromSelector(@selector(firstName))];  // 只读属性
    [personKvoObserver addObserverForKeyPath:NSStringFromSelector(@selector(lastName))];  // 只读属性
    [personKvoObserver addObserverForKeyPath:@"_age"];  // 不符合KVC访问方式，不能监听
    [personKvoObserver addObserverForKeyPath:@"readonly"];   // 对象属性的属性
    [personKvoObserver addObserverForKeyPath:@"fullName"];
    [personKvoObserver addObserverForKeyPath:@"friends"];   // 对象数组
    [personKvoObserver addObserverForKeyPath:@"innerName"]; // 内部属性
    [personKvoObserver addObserverForKeyPath:@"mutiFriends"];//
//    [personKvoObserver addObserverForKeyPath:@"mutiFriends"];//
//    [personKvoObserver addObserverForKeyPath:@"countOfMutiFriends"];

    p.firstName = @"zhao1";
    p.lastName = @"zhiyu1";
    [p changeAge:20];
//    [mutableLastName appendString:@"append"];
    fp.lastName = @"laoda1";
    p.friends = @[fri1, fri2];
    p.mutiFriends[0].firstName = @"changed";
    [p.mutiFriends addObject:fri2];
    NSMutableArray *kvo_mutableArray = [p mutableArrayValueForKey:@"mutiFriends"];
    [kvo_mutableArray addObject:fri2];
    ((Person*)(kvo_mutableArray[1])).firstName = @"sdfsdfsdfsdfdsfdsfdfsd";
    
    //
    NSLog(@"KVO proxy MutableArray class = %@",[kvo_mutableArray class]);
    NSLog(@"KVO proxy MutableArray object_getClass = %@",object_getClass(kvo_mutableArray));
    
//    ((Person*)([p mutableArrayValueForKey:@"mutiFriends"][0]).firstName = @"cjamge";
    [p setNewInnerName:@"newInnerNmame"];// 没有暴露的属性的get、set方法被调用时，也会发送通知

    //-----------------observationInfo
    NSLog(@"personKvoObserver.observationInfo %@",p.observationInfo);

    //------------------查看类的变化 ------------
    NSLog(@"Person self class = %@",[p class]);
    NSLog(@"Person object_getClass = %@",object_getClass(p));
    

    NSLog(@"--------");
    
    // -------------------- 子类 ---------------
    // 对象属性
    _stu = [[Student alloc] init];
    _stu.firstName = @"stu";
    _stu.lastName = @"dent";
    _stu.mark = @"65";
    [_stu setValue:@"jiaozi" forKey:@"loveFood"];
    
    _stuObserver = [[StudentKvoObserver alloc] initWithStudent:_stu];
    [_stuObserver addObserverForKeyPath:@"fullName"];// 子类继承属性依旧被监听
    [_stuObserver addObserverForKeyPath:@"firstName"];   // 重写方法,不加super,依旧会监听kvo
    [_stuObserver addObserverForKeyPath:@"mark"];   // 使用@synthesize将实例变量重命名
    [_stuObserver addObserverForKeyPath:@"loveFood"];   // 重命名get方法
    [_stuObserver addObserverForKeyPath:@"innerName"];
    [_stuObserver addObserverForKeyPath:@"readonly"];
    
    
//    KVOObserverManager *stuObserver = [[KVOObserverManager alloc] initWithObserver:stu];
//    [stuObserver observe:stu keyPath:@"fullName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(NSDictionary<NSKeyValueChangeKey,id> *change) {
//        NSLog(@"change = %@",change);
//    }];
//    [stu.KVO observe:stu keyPath:@"fullName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(NSDictionary<NSKeyValueChangeKey,id> *change) {
//        NSLog(@"change = %@",change);
//    }];
//
//    
//    stu.firstName = @"stu1";
//    [stu test];
//    stu.lastName = @"dent1";
//    stu.mark = @"85";
//    [stu setValue:@"baozi" forKey:@"loveFood"];
//    [stu setNewInnerName:@"newInnerNmame"];// 没有暴露的属性的get、set方法被调用时，也会发送通知
    

    // 1.通过多线程对值去改变
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _stu.lastName = @"stu_asyn_change";
        [_stu test];
    });
//
//    
//    // 2.在两个线程定义目标和观察者
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
////    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    __block Student *stu1 = nil;
//    dispatch_async(concurrentQueue, ^{
//        // 对象属性
//        stu1 = [[Student alloc] init];
//        NSLog(@"Student %@",[NSDate new]);
//
//        stu1.lastName = @"yyyyyyy";
//        
//    });
//    
//    __block StudentKvoObserver *stuObserver1;
//    dispatch_async(concurrentQueue, ^{
//        sleep(2);
//
//        stuObserver1 = [[StudentKvoObserver alloc] initWithStudent:stu1];
//        [stuObserver1 addObserverForKeyPath:@"fullName"];// 子类继承属性依旧被监听
//        [stuObserver1 addObserverForKeyPath:@"lastName"];
//        NSLog(@" StudentKvoObserver %@",[NSDate new]);
//
//    });
//    
//    dispatch_barrier_async(concurrentQueue, ^{
//        NSLog(@"dispatch_barrier_async %@",[NSDate new]);
//        NSLog(@"zzzzzz start%@",[NSDate new]);
//        stu1.lastName = @"zzzzzz";
//        NSLog(@"zzzzzz end%@",[NSDate new]);
//
//    });
//
//
//    sleep(10);
    
    
}



@end
