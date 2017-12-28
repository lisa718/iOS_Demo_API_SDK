//
//  ViewController.m
//  Launch_ImageSet
//
//  Created by baidu on 2017/10/25.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    
    for (int i = 0; i < 1000; i++) {
        @autoreleasepool {
            [UIImage imageNamed:@"article-list-normal22.jpg" inBundle:nil compatibleWithTraitCollection:nil];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
