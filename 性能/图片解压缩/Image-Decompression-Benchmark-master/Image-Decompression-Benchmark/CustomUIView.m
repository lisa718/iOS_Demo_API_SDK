//
//  CustomUIView.m
//  Image-Decompression-Benchmark
//
//  Created by baidu on 2017/10/7.
//  Copyright © 2017年 leichunfeng. All rights reserved.
//

#import "CustomUIView.h"

@implementation CustomUIView


- (void)drawRect:(CGRect)rect {
    
    (self.image)?[self drawImage:self.image rect:rect]:nil;
}

- (void)drawImage:(UIImage *)image rect:(CGRect)rect{
    CFAbsoluteTime before = CFAbsoluteTimeGetCurrent();

//    CGContextRef context = UIGraphicsGetCurrentContext();
    [image drawInRect:rect];
    
    
//    UIGraphicsBeginImageContext(rect.size);
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetShouldAntialias(context, NO);
//    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
//    CGContextSetBlendMode(context, kCGBlendModeCopy);
//    
////    [image drawAtPoint:CGPointZero];
//    [image drawInRect:rect];
//    UIGraphicsEndImageContext();
    
    CFAbsoluteTime after = CFAbsoluteTimeGetCurrent();
    
    NSLog(@"Draw: %.2f ms", (after - before) * 1000);
}

@end
