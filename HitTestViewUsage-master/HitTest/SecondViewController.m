//
//  SecondViewController.m
//  HitTestViewDemo
//
//  Created by Slemon on 15/11/25.
//  Copyright © 2015年 Lemons. All rights reserved.
//

#import "SecondViewController.h"
#import "UIButton+HitAreaExpand.h"
#import "AView.h"
#import "BView.h"

@interface SecondViewController ()

- (IBAction)buttonAction:(id)sender;
@property (nonatomic,retain) AView *father;
@property (nonatomic,retain) UIButton *button;
@property (nonatomic,retain) BView *son;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fatherGes:)];
//    ges.delegate = self;

    // Do any additional setup after loading the view.
    self.father = [[AView alloc] initWithFrame:CGRectMake(60, 60, 200, 200)];
    [self.view addSubview:_father];
    [self.father addGestureRecognizer:ges];
    _father.backgroundColor = [UIColor grayColor];
//    self.father.layer.masksToBounds = YES;

    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(100, 100, 150, 150);
    _button.backgroundColor = [UIColor yellowColor];
//    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testButtonGes:)];
//    ges.cancelsTouchesInView = NO;
//    [_button addGestureRecognizer:ges];
    [_button addTarget:self action:@selector(testButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_father addSubview:_button];
    
//    _button.minHitTestWidth = 500;
//    _button.minHitTestHeight = 500;
    
//    self.son = [[BView alloc] initWithFrame:CGRectMake(20, 100, 100, 100)];
//    [self.view addSubview:self.son];
//    _son.backgroundColor = [UIColor greenColor];
//     [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sonGes:)]];
    self.button.frame;
    NSLog(@"a");

}

- (void)testButtonAction:(UIButton *)button {
    NSLog(@"%s",__FUNCTION__);

}

- (void)testButtonGes:(UIGestureRecognizer *)ges {
    NSLog(@"%s",__FUNCTION__);
}

- (void)fatherGes:(UIGestureRecognizer *)ges {
    NSLog(@"%s",__FUNCTION__);
}

- (void)sonGes:(UIGestureRecognizer *)ges {
    NSLog(@"%s",__FUNCTION__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonAction:(id)sender {
    NSLog(@"button has been pressed!!!!");
}

#pragma mark -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.view]) {
        return YES;
    }
    return NO;
}
@end
