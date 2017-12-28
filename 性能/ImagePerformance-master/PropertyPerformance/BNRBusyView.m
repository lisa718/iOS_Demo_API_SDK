//
//  BNRBusyView.m
//  PropertyPerformance
//
//  Created by John Gallagher on 9/5/13.
//  Copyright (c) 2013 BigNerdRanch. All rights reserved.
//

#import "BNRBusyView.h"

#ifdef __ARM_NEON__
#import <arm_neon.h>
#endif

// KVO keyPaths.
NSString *const BNRBusyViewKeyLoopStyle = @"loopStyle";
NSString *const BNRBusyViewKeyLoopSize = @"loopSize";
NSString *const BNRBusyViewKeyLog2LoopSize = @"log2LoopSize";

// NSUserDefaults keys.
static NSString *const BNRBusyViewDefaultLog2LoopSizeKey = @"BNRBusyViewDefaultLog2LoopSizeKey";
static NSString *const BNRBusyViewDefaultLoopStyleKey = @"BNRBusyViewDefaultLoopStyleKey";

@interface BNRBusyView () {
    volatile CGFloat _volatileIVar;
    CGFloat _normalIVar;
}

// Dummy property we'll use in our inner loop below.
@property (nonatomic, assign) CGFloat property;

// Avoid making the UI thread unresponsive.
@property (nonatomic, strong) dispatch_queue_t queue;

// Animating a circle.
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

// Keep track of FPS.
@property (nonatomic, strong) NSDate *lastFpsUpdate;
@property (nonatomic, assign) NSInteger frameUpdates;
@property (nonatomic, weak) UILabel *fpsLabel;
@property (nonatomic,strong) UILabel *excTimeLabel;
@property (nonatomic,assign) CGFloat  timeInterval;
@property (nonatomic,assign) int count;

@end

@implementation BNRBusyView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.property = 1.0f;
        _volatileIVar = 1.0f;
        _normalIVar = 1.0f;
        self.queue = dispatch_queue_create("com.bignerdranch.PropertyPerformance", DISPATCH_QUEUE_SERIAL);
        
        UILabel *fpsLabel = [[UILabel alloc] init];
        fpsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        fpsLabel.backgroundColor = self.backgroundColor;
        fpsLabel.textColor = [UIColor blueColor];
        fpsLabel.text = @"FPS";
        [self addSubview:fpsLabel];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:fpsLabel
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:fpsLabel
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        
        self.fpsLabel = fpsLabel;
        
        [self addSubview:self.excTimeLabel];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fpsLabel
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.excTimeLabel
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.excTimeLabel
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.fpsLabel
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:20.0f]];

//        [self registerDefaults];
    }
    return self;
}

#pragma mark - NSUserDefaults

- (void)registerDefaults
{
    [[NSUserDefaults standardUserDefaults]
     registerDefaults:@{BNRBusyViewDefaultLoopStyleKey:    @(BNRBusyViewLoopStyleProperties),
                        BNRBusyViewDefaultLog2LoopSizeKey: @(17)}];
}

- (void)loadSettingsFromDefaults
{
    self.log2LoopSize = [[[NSUserDefaults standardUserDefaults] valueForKey:BNRBusyViewDefaultLog2LoopSizeKey] unsignedIntegerValue];
    self.loopStyle = [[[NSUserDefaults standardUserDefaults] valueForKey:BNRBusyViewDefaultLoopStyleKey] integerValue];
}

#pragma mark - Properties

- (UILabel *)excTimeLabel {
    if (nil == _excTimeLabel) {
        _excTimeLabel = [UILabel new];
        _excTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _excTimeLabel.backgroundColor = self.backgroundColor;
        _excTimeLabel.textColor = [UIColor blueColor];
        _excTimeLabel.text = @"ExcTime:";
    }
    return _excTimeLabel;
}

- (NSUInteger)loopSize
{
    return self.log2LoopSize;
}

- (void)setLog2LoopSize:(NSUInteger)log2LoopSize
{
    [self willChangeValueForKey:BNRBusyViewKeyLoopSize];
    _log2LoopSize = log2LoopSize;
//    [[NSUserDefaults standardUserDefaults] setValue:@(log2LoopSize) forKey:BNRBusyViewDefaultLog2LoopSizeKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    [self didChangeValueForKey:BNRBusyViewKeyLoopSize];
}

- (void)setLoopStyle:(BNRBusyViewLoopStyle)loopStyle
{
    _loopStyle = loopStyle;
    [[NSUserDefaults standardUserDefaults] setValue:@(loopStyle) forKey:BNRBusyViewDefaultLoopStyleKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return BNRBusyViewNumLoopStyles;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
#ifndef TEST_IMAGE
    BNRBusyViewLoopStyle style = (BNRBusyViewLoopStyle)row;
    switch (style) {
        case BNRBusyViewLoopStyleConstant:     return @"Constant";
        case BNRBusyViewLoopStyleIVars:        return @"Normal iVar";
        case BNRBusyViewLoopStyleVolatileIVar: return @"Volatile iVar";
        case BNRBusyViewLoopStyleProperties:   return @"Property";
#ifdef __ARM_NEON__
        case BNRBusyViewLoopStyleNeon64:       return @"NEON (64-bit)";
        case BNRBusyViewLoopStyleNeon128:      return @"NEON (128-bit)";
#endif
            
            // Sentinel should never actually show up here.
        case BNRBusyViewNumLoopStyles:         return @"programmer error";
    }
#else
    NSString *str = @"";
    if (row == 0) {
        str = @"imageNamed no assets";
    }
    else if (row == 1){
        str = @"imageNamed compatible no assets";
    }
    else if (row == 2){
        str = @"imageNamed in assets";
    }
    else if (row == 3){
        str = @"imageNamed compatible assets";
    }
    return str;
#endif
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.loopStyle = (BNRBusyViewLoopStyle)row;
}

#pragma mark - Real work

- (void)updatePosition
{
    __weak BNRBusyView *weakSelf = self;
    dispatch_async(self.queue, ^{
        __strong BNRBusyView *strongSelf = weakSelf;

        CGFloat mid = MIN(strongSelf.bounds.size.height, strongSelf.bounds.size.width) / 2.0f;
        CGFloat radius = mid - 20.0f;
        strongSelf.angle += 0.01f;
        
        CGFloat x = 0;
        
        NSUInteger loopSize = strongSelf.loopSize;
        CFAbsoluteTime before = CFAbsoluteTimeGetCurrent();
        switch (strongSelf.loopStyle) {
            case BNRBusyViewLoopStyleVolatileIVar:
                
                for (NSUInteger i = 0; i < loopSize; i++) {
#ifdef TEST_IMAGE
                    @autoreleasepool {
                        UIImage *image = [UIImage imageNamed:@"student1" inBundle:nil compatibleWithTraitCollection:nil];
                        UIImage *image2 = [UIImage imageNamed:@"loading_asset" inBundle:nil compatibleWithTraitCollection:nil];
                        
                    }
#else
                    x += _volatileIVar;
#endif
                }
            
                break;
                
            case BNRBusyViewLoopStyleIVars:
                for (NSUInteger i = 0; i < loopSize; i++) {
                    
#ifdef TEST_IMAGE
                    @autoreleasepool {
                        UIImage *image = [UIImage imageNamed:@"student" inBundle:nil compatibleWithTraitCollection:nil];
                        UIImage *image2 = [UIImage imageNamed:@"loading" inBundle:nil compatibleWithTraitCollection:nil];
                        
                    }
#else
                    x += _normalIVar;
#endif
                }
                break;
                
            case BNRBusyViewLoopStyleProperties:
                for (NSUInteger i = 0; i < loopSize; i++) {
#ifdef TEST_IMAGE
                    @autoreleasepool {
                        UIImage *image = [UIImage imageNamed:@"student"];
                        UIImage *image2 = [UIImage imageNamed:@"loading"];
                        
                    }
#else
                    x += strongSelf.property;
#endif
                }
                break;
                
            case BNRBusyViewLoopStyleConstant:
                for (NSUInteger i = 0; i < loopSize; i++) {
#ifdef TEST_IMAGE
                    @autoreleasepool {
                        UIImage *image = [UIImage imageNamed:@"student1"];
                        UIImage *image2 = [UIImage imageNamed:@"loading_asset"];
                        
                    }
#else
                    x += 1.0f;
#endif
                }
                break;
                
#ifdef __ARM_NEON__
            case BNRBusyViewLoopStyleNeon64:
            {
                float32x2_t x_pair = vmov_n_f32(0.0f);
                for (NSUInteger i = 0; i < loopSize; i += 2) {
                    float32x2_t pair = vmov_n_f32(_property);
                    x_pair = vadd_f32(x_pair, pair);
                }
                x = vget_lane_f32(x_pair, 0) + vget_lane_f32(x_pair, 1);
            }
                break;
                
            case BNRBusyViewLoopStyleNeon128:
            {
                float32x4_t x_quad = vmovq_n_f32(0.0f);
                for (NSUInteger i = 0; i < loopSize; i += 4) {
                    float32x4_t quad = vmovq_n_f32(_property);
                    x_quad = vaddq_f32(x_quad, quad);
                }
                x  = vgetq_lane_f32(x_quad, 0);
                x += vgetq_lane_f32(x_quad, 1);
                x += vgetq_lane_f32(x_quad, 2);
                x += vgetq_lane_f32(x_quad, 3);
            }
                break;
#endif
                
            case BNRBusyViewNumLoopStyles:
                NSLog(@"programmer error");
                break;
        }
        CFAbsoluteTime after = CFAbsoluteTimeGetCurrent();
        self.timeInterval += after - before;
        self.count++;
        
        x -= loopSize;
        x += mid + radius * cosf(strongSelf.angle);
        strongSelf.x = x;
        strongSelf.y = mid + radius * sinf(strongSelf.angle);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf setNeedsDisplay];
        });
    });
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.frameUpdates++;
    NSDate *now = [NSDate date];
    if (!self.lastFpsUpdate) {
        self.lastFpsUpdate = now;
    }
    NSTimeInterval secondsSinceLastFpsUpdate = [now timeIntervalSinceDate:self.lastFpsUpdate];
    if (secondsSinceLastFpsUpdate > 1.0) {
        self.fpsLabel.text = [NSString stringWithFormat:@"FPS: %.1f", self.frameUpdates / secondsSinceLastFpsUpdate];
        // 计算平均时长
        if (self.timeInterval > 0) {
            [self.excTimeLabel setText:[NSString stringWithFormat:@"EXCTime : %.3f ms",self.timeInterval/self.count*1000.0]];
            self.timeInterval = 0;
        }
        self.frameUpdates = 0;
        self.count = 0;
        self.lastFpsUpdate = now;
        
    }
   
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);
    CGRect circleRect = CGRectMake(self.x, self.y, 10.0f, 10.0f);
    CGContextFillEllipseInRect(ctx, circleRect);
    
    [self updatePosition];
}

@end
