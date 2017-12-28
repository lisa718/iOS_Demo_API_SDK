//
//  UIImage+Cicle.m
//  RunLoopDemo03
//
//  Created by baidu on 2017/10/18.
//  Copyright © 2017年 Haley. All rights reserved.
//

#import "UIImage+Cicle.h"

@implementation UIImage (Cicle)

- (UIImage *)drawCircleImageWithBound:(CGRect)bounds{
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:50] addClip];
    [self drawInRect:bounds];
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

@end
