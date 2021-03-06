//
//  ViewController.m
//  TapTest
//
//  Created by wupei on 2017/5/25.
//  Copyright © 2017年 wupei. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"


@interface ViewController ()

@property (nonatomic,strong) TestView *testView;//测试view

@property (nonatomic,strong) UIButton *testBtn;//测试Btn
@property (nonatomic,strong) UITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.testView = [[TestView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.testView];
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(100);
    }];
    
    self.testView.backgroundColor = [UIColor colorWithRed:0 green:254 blue:254 alpha:1];
    
    

    self.testBtn = [[UIButton alloc] init];
    self.testBtn.backgroundColor = [UIColor yellowColor];
    
    [self.testBtn setTitle:@"我是按钮" forState:UIControlStateNormal];
    [self.testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.testBtn];
    [self.testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.testView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(100);
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    tap.delegate = self;
//    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    [_testBtn addTarget:self action:@selector(testBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 300) style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    self.tableview.delegate = (id<UITableViewDelegate>)self;
    self.tableview.dataSource = (id<UITableViewDataSource>)self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"=========> base view touchs Began");
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"=========> base view touchs Moved");
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"=========> base view touchs Ended");
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"=========> base view touchs Cancelled");
}

- (void)tapAction {
    NSLog(@"=========> single Tapped");
}
- (void)testBtnClicked {
    NSLog(@"=========> click testbtn");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__FUNCTION__);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"abc"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"abc"];
    }
    cell.textLabel.text = @"a";
    return cell;
}
#pragma mark -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.tableview]) {
        return NO;
    }
    return YES;
}


@end
