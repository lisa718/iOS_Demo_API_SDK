//
//  ViewController.m
//  Image-Decompression-Benchmark
//
//  Created by leichunfeng on 2017/2/22.
//  Copyright © 2017年 leichunfeng. All rights reserved.
//

#import "ViewController.h"
#import <YYKit/YYKit.h>
#import <SDWebImage/SDWebImageDecoder.h>
#import <FLAnimatedImage/FLAnimatedImage.h>
#import "CustomUIView.h"

@interface UIImage (Initialization)

@end

@implementation UIImage (Initialization)

+ (UIImage *)imageNamed:(NSString *)name ofType:(NSString *)ext {
    CFAbsoluteTime before = CFAbsoluteTimeGetCurrent();
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:ext];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    CFAbsoluteTime after = CFAbsoluteTimeGetCurrent();
    
    NSLog(@"%@", path.lastPathComponent);
    NSLog(@"Init: %.2f ms", (after - before) * 1000);
    
    return image;
}

@end

@interface FLAnimatedImage ()

+ (UIImage *)predrawnImageFromImage:(UIImage *)imageToPredraw;

@end

#pragma mark - ViewController

@interface ViewController()

@property (nonatomic,strong) NSMutableArray<CustomUIView*> *drawViewArray;
@property (nonatomic,strong) CustomUIView* drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.drawView];
    
    NSArray *names = @[ @"128x96", @"256x192", @"512x384", @"1024x768", @"2048x1536" ];
    NSArray *exts  = @[ @"png", @"jpg" ];
    
    for (NSString *name in names) {
        for (NSString *ext in exts) {
            @autoreleasepool {
            
            NSLog(@"--------------------------------------------------------------------------------");
            
            UIImage *image = nil;
            
//            image = [UIImage imageNamed:name ofType:ext];
//            image = [self decompressImageByYYKit:image];
//            [self drawImage:image];
            
            image = [UIImage imageNamed:name ofType:ext];
            image = [self decompressImageBySDWebImage:image];
            // 给custom view 进行绘制
            self.drawView.image = image;
            [self.drawView setNeedsDisplay];
                
            // viewcontroller进行虚假绘制
//            [self drawImage:image];
            
//            image = [UIImage imageNamed:name ofType:ext];
//            image = [self decompressImageByFLAnimatedImage:image];
//            [self drawImage:image];
            }
        }
    }
    
    NSLog(@"--------------------------------------------------------------------------------");
}

- (UIImage *)decompressImageByYYKit:(UIImage *)image {
    CFAbsoluteTime before = CFAbsoluteTimeGetCurrent();
    
    CGImageRef cgImage = YYCGImageCreateDecodedCopy(image.CGImage, YES);
    UIImage *decompressedImage = [UIImage imageWithCGImage:cgImage scale:image.scale orientation:image.imageOrientation];
    
    CFAbsoluteTime after = CFAbsoluteTimeGetCurrent();
    
    NSLog(@"Decompress by YYKit: %.2f ms", (after - before) * 1000);
    
    return decompressedImage;
}

- (UIImage *)decompressImageBySDWebImage:(UIImage *)image {
    CFAbsoluteTime before = CFAbsoluteTimeGetCurrent();
    
    UIImage *decompressedImage = [UIImage decodedImageWithImage:image];
    CFAbsoluteTime after = CFAbsoluteTimeGetCurrent();
    
    NSLog(@"Decompress by SDWebImage: %.2f ms", (after - before) * 1000);
    
    return decompressedImage;
}

- (UIImage *)decompressImageByFLAnimatedImage:(UIImage *)image {
    CFAbsoluteTime before = CFAbsoluteTimeGetCurrent();
    
    UIImage *decompressedImage = [FLAnimatedImage predrawnImageFromImage:image];
    CFAbsoluteTime after = CFAbsoluteTimeGetCurrent();
    
    NSLog(@"Decompress by FLAnimatedImage: %.2f ms", (after - before) * 1000);
    
    return decompressedImage;
}

- (void)drawImage:(UIImage *)image {
    CFAbsoluteTime before = CFAbsoluteTimeGetCurrent();
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShouldAntialias(context, NO);
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    [image drawAtPoint:CGPointZero];
    
    UIGraphicsEndImageContext();
    
    CFAbsoluteTime after = CFAbsoluteTimeGetCurrent();
    
    NSLog(@"Draw: %.2f ms", (after - before) * 1000);
}

#pragma mark - getters & setters
- (NSMutableArray<CustomUIView*> *)drawViewArray{
    if (nil == _drawViewArray) {
        _drawViewArray = [[NSMutableArray alloc] init];
    }
    return _drawViewArray;
}

- (CustomUIView *)drawView {
    if (nil == _drawView){
        _drawView = [[CustomUIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    return _drawView;
}

@end
