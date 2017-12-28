//
//  TypeCastUtil.h
//  Weibo
//
//  Created by Wade Cheng on 8/19/13.
//  Copyright (c) 2013 Sina. All rights reserved.
//

#if !defined(TARGET_OS_IPHONE) || !TARGET_OS_IPHONE
#import <Foundation/NSGeometry.h> // For NSPoint, NSSize, and NSRect
#import <AppKit/AppKit.h>
#else
#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIKit.h>
#endif

#if !defined(TARGET_OS_IPHONE) || !TARGET_OS_IPHONE
#define CGPointValue pointValue
#define CGRectValue rectValue
#define CGSizeValue sizeValue
#define UIImage NSImage
#else
#import <UIKit/UIGeometry.h>
#define NSPointFromString CGPointFromString
#define NSRectFromString CGRectFromString
#define NSSizeFromString CGSizeFromString
#define NSZeroPoint CGPointZero
#define NSZeroSize CGSizeZero
#define NSZeroRect CGRectZero
#endif

NSNumber *wb_numberOfValue(id value, NSNumber *defaultValue);

NSString *wb_stringOfValue(id value, NSString *defaultValue);

NSArray *wb_stringArrayOfValue(id value, NSArray *defaultValue);

NSDictionary *wb_dictOfValue(id value, NSDictionary *defaultValue);

NSArray *wb_arrayOfValue(id value ,NSArray *defaultValue);

float wb_floatOfValue(id value, float defaultValue);

double wb_doubleOfValue(id value, double defaultValue);

CGPoint wb_pointOfValue(id value, CGPoint defaultValue);

CGSize wb_sizeOfValue(id value, CGSize defaultValue);

CGRect wb_rectOfValue(id value, CGRect defaultValue);

BOOL wb_boolOfValue(id value, BOOL defaultValue);

int wb_intOfValue(id value, int defaultValue);

unsigned int wb_unsignedIntOfValue(id value, unsigned int defaultValue);

long long int wb_longLongOfValue(id value, long long int defaultValue);

unsigned long long int wb_unsignedLongLongOfValue(id value, unsigned long long int defaultValue);

NSInteger wb_integerOfValue(id value, NSInteger defaultValue);

NSUInteger wb_unsignedIntegerOfValue(id value, NSUInteger defaultValue);

UIImage *wb_imageOfValue(id value, UIImage *defaultValue);

UIColor *wb_colorOfValue(id value, UIColor *defaultValue);

time_t wb_timeOfValue(id value, time_t defaultValue);

NSDate *wb_dateOfValue(id value);