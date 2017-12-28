//
//  ViewController.m
//  RunLoopDemo03
//
//  Created by Harvey on 2016/12/14.
//  Copyright © 2016年 Haley. All rights reserved.
//

#import "ViewController.h"
#import "FluencyMonitor.h"
#import "BSBacktraceLogger.h"
#import "UIImage+Cicle.h"
#import <CrashReporter/CrashReporter.h>


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIView *labelView;
@property (nonatomic,strong) CATextLayer *textLayer;
@property (nonatomic,strong) CADisplayLink *link;
@property (nonatomic,assign) NSTimeInterval lastTime;
@property (nonatomic,strong) NSCache *imageCache;


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self.view addSubview:self.labelView];
    [self.labelView.layer addSublayer:self.textLayer];
//    self.textLayer.string = @"sdsfd";
    
    self.tableView.rowHeight = 135.f;
    
    self.navigationItem.titleView = self.labelView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(stopMonitor)];
    [self startMonitor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testNotify) name:@"test" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testNotify) name:@"test" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"test" object:nil]];
}

- (void)testNotify {
    NSLog(@"copy");
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    for (NSInteger i = 1; i <= 5; i++) {
        [[cell.contentView viewWithTag:i] removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 25)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"%zd - Drawing index is top priority", indexPath.row];
    label.font = [UIFont boldSystemFontOfSize:13];
    label.tag = 1;
    [cell.contentView addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(105, 20, 85, 85)];
    imageView.tag = 2;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"spaceship" ofType:@"jpg"];
//    NSLog(@"path=%@",path);

//    UIImage *image = [UIImage imageWithContentsOfFile:path];
    [self asynSetImage:path configCell:^(UIImage *image) {
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
//         [self setImageInRunLoop:image view:imageView];
    }];

//    NSLog(@"current:%@",[NSRunLoop currentRunLoop].currentMode);
    [cell.contentView addSubview:imageView];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 20, 85, 85)];
    imageView2.tag = 3;
    [cell.contentView addSubview:imageView2];
//    UIImage *image2 = [UIImage imageWithContentsOfFile:path];
    [self asynSetImage:path configCell:^(UIImage *image) {
        
        
        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        [imageView2 performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
//         [self setImageInRunLoop:image view:imageView2];
    }];
   

    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 99, 300, 35)];
    label2.lineBreakMode = NSLineBreakByWordWrapping;
    label2.numberOfLines = 0;
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = [UIColor colorWithRed:0 green:100.f/255.f blue:0 alpha:1];
    label2.text = [NSString stringWithFormat:@"%zd - Drawing large image is low priority. Should be distributed into different run loop passes.", indexPath.row];
    label2.font = [UIFont boldSystemFontOfSize:13];
    label2.tag = 4;
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, 85, 85)];
    imageView3.tag = 5;
//    UIImage *image3 = [UIImage imageWithContentsOfFile:path];
    [self asynSetImage:path configCell:^ (UIImage *image) {
        imageView3.contentMode = UIViewContentModeScaleAspectFit;
        //    imageView3.image = image3;
        [imageView3 performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
    
//        [self setImageInRunLoop:image view:imageView3];
    }];
    
    
    [cell.contentView addSubview:label2];
    [cell.contentView addSubview:imageView3];
    
    return cell;
}


#pragma mark - setImageAsyn
- (void)setImageInRunLoop:(UIImage *)image view:(UIImageView *)imageView{
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopBeforeWaiting, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        //    imageView3.image = image3;
        [imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
        
        CFRunLoopRemoveObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
        CFRelease(observer);
    });
    
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
}

- (void)asynSetImage:(NSString *)imageName configCell:(void (^)(UIImage *image))configCell{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
        UIImage *aimage = [self.imageCache objectForKey:imageName];
        if (!aimage) {
            aimage = [UIImage imageWithContentsOfFile:imageName];
        }
        UIImage* cImage = [aimage drawCircleImageWithBound:CGRectMake(0, 0, 85, 85)];
        [self.imageCache setObject:aimage forKey:cImage];
        
//        UIImage *aimage = [UIImage imageNamed:imageName];
        dispatch_async(dispatch_get_main_queue(), ^{
            configCell(cImage);
        });
    });
}

- (void)handleStackInfo
{
//    NSData *lagData = [[[PLCrashReporter alloc]
//                        initWithConfiguration:[[PLCrashReporterConfig alloc] initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeBSD symbolicationStrategy:PLCrashReporterSymbolicationStrategyAll]] generateLiveReport];
//    PLCrashReport *lagReport = [[PLCrashReport alloc] initWithData:lagData error:NULL];
//    NSString *lagReportString = [PLCrashReportTextFormatter stringValueForCrashReport:lagReport withTextFormat:PLCrashReportTextFormatiOS];
//    //将字符串上传服务器
//    NSLog(@"lag happen, detail below: \n %@",lagReportString);
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            BSLOG_MAIN  // 打印主线程调用栈， BSLOG 打印当前线程，BSLOG_ALL 打印所有线程
//            [BSBacktraceLogger bs_backtraceOfCurrentThread]; //这一系列的方法可以获取字符串，然后选择上传服务器或者其他处理。
    //    });
}

#pragma mark -  monitor
- (void)tick:(CADisplayLink *)link {
    
    if (self.lastTime == 0) {
        self.lastTime = link.timestamp;
        return;
    }

    static int count = 0;

    NSTimeInterval timeForOneFrame = link.timestamp - self.lastTime; // ms
//    if (timeForOneFrame < 1) {
//        return;
//    }
//    count++;
    self.lastTime = link.timestamp;
    int fps = (int)(1/timeForOneFrame);
//    count = 0;
    
    self.textLayer.string = [@(fps) stringValue];
    [self.textLayer setNeedsDisplay];

    if (fps < 50 ) {
        count ++;
        if (count >= 5 ) {
            NSLog(@"卡了");
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"%@",[NSThread callStackSymbols]);
//            });
            [self handleStackInfo];
        }
        
    }
    else{
        count = 0;
    }
  
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]  range:NSMakeRange(text.length - 3, 3)];

    
    self.textLayer.string = text;

    
}
- (void)startMonitor {
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)stopMonitor
{
    //    [[FluencyMonitor shareMonitor] stop];
    [self.link invalidate];
//    UIViewController *vc = [[UIViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark - getters && setters
- (UIView *)labelView {
    if (nil == _labelView) {
        _labelView = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 50)];
        _labelView.backgroundColor = [UIColor grayColor];
        
    }
    return _labelView;
}

- (CATextLayer *)textLayer {
    if (nil == _textLayer) {
        // 创建layer
        _textLayer = [CATextLayer layer];
        _textLayer.frame = _labelView.bounds;
        
        // 设置属性
        _textLayer.alignmentMode = kCAAlignmentCenter;
        _textLayer.foregroundColor = [UIColor redColor].CGColor;
        //choose a font
        UIFont *font = [UIFont systemFontOfSize:15];
        
        //set layer font
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        _textLayer.font = fontRef;
        _textLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
    }
    return _textLayer;
}

- (NSCache *)imageCache {
    if (nil == _imageCache) {
        _imageCache = [[NSCache alloc] init];
    }
    return _imageCache;
}

@end
