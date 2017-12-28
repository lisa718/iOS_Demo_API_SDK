//
//  NSArray+TypeCast.m
//  Weibo
//
//  Created by Wade Cheng on 8/19/13.
//  Copyright (c) 2013 Sina. All rights reserved.
//

#import "NSArray+TypeCast.h"

#import "TypeCastUtil.h"

#define OAI [self wb_safeObjectAtIndex:index]

@implementation NSArray (TypeCast)

- (id)wb_safeObjectAtIndex:(NSUInteger)index
{
    return (index >= self.count) ? nil : [self objectAtIndex:index];
}

#pragma mark - NSObject

- (id)wb_objectAtIndex:(NSUInteger)index
{
    return OAI;
}

#pragma mark - NSNumber

- (NSNumber *)wb_numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)defaultValue
{
    return wb_numberOfValue(OAI, defaultValue);
}

- (NSNumber *)wb_numberAtIndex:(NSUInteger)index
{
	return [self wb_numberAtIndex:index defaultValue:nil];
}

#pragma mark - NSString

- (NSString *)wb_stringAtIndex:(NSUInteger)index defaultValue:(NSString *)defaultValue;
{
    return wb_stringOfValue(OAI, defaultValue);
}

- (NSString *)wb_stringAtIndex:(NSUInteger)index;
{
    return [self wb_stringAtIndex:index defaultValue:nil];
}

#pragma mark - NSArray of NSString

- (NSArray *)wb_stringArrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue
{
    return wb_stringArrayOfValue(OAI, defaultValue);
}

- (NSArray *)wb_stringArrayAtIndex:(NSUInteger)index;
{
    return [self wb_stringArrayAtIndex:index defaultValue:nil];
}

#pragma mark - NSDictionary

- (NSDictionary *)wb_dictAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)defaultValue
{
    return wb_dictOfValue(OAI, defaultValue);
}

- (NSDictionary *)wb_dictAtIndex:(NSUInteger)index
{
    return [self wb_dictAtIndex:index defaultValue:nil];
}

#pragma mark - NSArray

- (NSArray *)wb_arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue
{
    return wb_arrayOfValue(OAI, defaultValue);
}

- (NSArray *)wb_arrayAtIndex:(NSUInteger)index
{
    return [self wb_arrayAtIndex:index defaultValue:nil];
}

#pragma mark - Float

- (float)wb_floatAtIndex:(NSUInteger)index defaultValue:(float)defaultValue;
{
    return wb_floatOfValue(OAI, defaultValue);
}

- (float)wb_floatAtIndex:(NSUInteger)index;
{
    return [self wb_floatAtIndex:index defaultValue:0.0f];
}

#pragma mark - Double

- (double)wb_doubleAtIndex:(NSUInteger)index defaultValue:(double)defaultValue;
{
    return wb_doubleOfValue(OAI, defaultValue);
}

- (double)wb_doubleAtIndex:(NSUInteger)index;
{
    return [self wb_doubleAtIndex:index defaultValue:0.0];
}

#pragma mark - CGPoint

- (CGPoint)wb_pointAtIndex:(NSUInteger)index defaultValue:(CGPoint)defaultValue
{
    return wb_pointOfValue(OAI, defaultValue);
}

- (CGPoint)wb_pointAtIndex:(NSUInteger)index;
{
    return [self wb_pointAtIndex:index defaultValue:NSZeroPoint];
}

#pragma mark - CGSize

- (CGSize)wb_sizeAtIndex:(NSUInteger)index defaultValue:(CGSize)defaultValue;
{
    return wb_sizeOfValue(OAI, defaultValue);
}

- (CGSize)wb_sizeAtIndex:(NSUInteger)index;
{
    return [self wb_sizeAtIndex:index defaultValue:NSZeroSize];
}

#pragma mark - CGRect

- (CGRect)wb_rectAtIndex:(NSUInteger)index defaultValue:(CGRect)defaultValue;
{
    return wb_rectOfValue(OAI, defaultValue);
}

- (CGRect)wb_rectAtIndex:(NSUInteger)index;
{
    return [self wb_rectAtIndex:index defaultValue:NSZeroRect];
}

#pragma mark - BOOL

- (BOOL)wb_boolAtIndex:(NSUInteger)index defaultValue:(BOOL)defaultValue;
{
    return wb_boolOfValue(OAI, defaultValue);
}

- (BOOL)wb_boolAtIndex:(NSUInteger)index;
{
    return [self wb_boolAtIndex:index defaultValue:NO];
}

#pragma mark - Int

- (int)wb_intAtIndex:(NSUInteger)index defaultValue:(int)defaultValue;
{
    return wb_intOfValue(OAI, defaultValue);
}

- (int)wb_intAtIndex:(NSUInteger)index;
{
    return [self wb_intAtIndex:index defaultValue:0];
}

#pragma mark - Unsigned Int

- (unsigned int)wb_unsignedIntAtIndex:(NSUInteger)index defaultValue:(unsigned int)defaultValue;
{
    return wb_unsignedIntOfValue(OAI, defaultValue);
}

- (unsigned int)wb_unsignedIntAtIndex:(NSUInteger)index;
{
    return [self wb_unsignedIntAtIndex:index defaultValue:0];
}

#pragma mark - Long Long

- (long long int)wb_longLongAtIndex:(NSUInteger)index defaultValue:(long long int)defaultValue
{
    return wb_longLongOfValue(OAI, defaultValue);
}

- (long long int)wb_longLongAtIndex:(NSUInteger)index
{
    return [self wb_longLongAtIndex:index defaultValue:0LL];
}

#pragma mark - Unsigned Long Long

- (unsigned long long int)wb_unsignedLongLongAtIndex:(NSUInteger)index defaultValue:(unsigned long long int)defaultValue;
{
    return wb_unsignedLongLongOfValue(OAI, defaultValue);
}

- (unsigned long long int)wb_unsignedLongLongAtIndex:(NSUInteger)index;
{
    return [self wb_unsignedLongLongAtIndex:index defaultValue:0ULL];
}

#pragma mark - NSInteger

- (NSInteger)wb_integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)defaultValue;
{
    return wb_integerOfValue(OAI, defaultValue);
}

- (NSInteger)wb_integerAtIndex:(NSUInteger)index;
{
    return [self wb_integerAtIndex:index defaultValue:0];
}

#pragma mark - Unsigned Integer

- (NSUInteger)wb_unsignedIntegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)defaultValue
{
	return wb_unsignedIntegerOfValue(OAI, defaultValue);
}

- (NSUInteger)wb_unsignedIntegerAtIndex:(NSUInteger)index
{
	return [self wb_unsignedIntegerAtIndex:index defaultValue:0];
}

#pragma mark - UIImage

- (UIImage *)wb_imageAtIndex:(NSUInteger)index defaultValue:(UIImage *)defaultValue
{
    return wb_imageOfValue(OAI, defaultValue);
}

- (UIImage *)wb_imageAtIndex:(NSUInteger)index
{
	return [self wb_imageAtIndex:index defaultValue:nil];
}

#pragma mark - UIColor

- (UIColor *)wb_colorAtIndex:(NSUInteger)index defaultValue:(UIColor *)defaultValue
{
    return wb_colorOfValue(OAI, defaultValue);
}

- (UIColor *)wb_colorAtIndex:(NSUInteger)index
{
	return [self wb_colorAtIndex:index defaultValue:[UIColor whiteColor]];
}

#pragma mark - Time

- (time_t)wb_timeAtIndex:(NSUInteger)index defaultValue:(time_t)defaultValue
{
    return wb_timeOfValue(OAI, defaultValue);
}

- (time_t)wb_timeAtIndex:(NSUInteger)index
{
    time_t defaultValue = [[NSDate date] timeIntervalSince1970];
    return [self wb_timeAtIndex:index defaultValue:defaultValue];
}

#pragma mark - NSDate

- (NSDate *)wb_dateAtIndex:(NSUInteger)index
{
    return wb_dateOfValue(OAI);
}

#pragma mark - Enumerate

- (void)wb_enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [self enumerateObjectsUsingBlock:block];
}

- (void)wb_enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block withCastFunction:(id (*)(id, id))castFunction
{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id castedObj = castFunction(obj, nil);
        if (castedObj)
        {
            block(castedObj, idx, stop);
        }
    }];
}

- (void)wb_enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block classes:(id)object, ...
{
    if (!object) return;
    NSMutableArray* classesArray = [NSMutableArray array];
	id paraObj = object;
	va_list objects;
	va_start(objects, object);
	do
	{
		[classesArray addObject:paraObj];
		paraObj = va_arg(objects, id);
	} while (paraObj);
	va_end(objects);
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BOOL allowBlock = NO;
        for (int i = 0; i < classesArray.count; i++)
        {
            if ([obj isKindOfClass:[classesArray objectAtIndex:i]])
            {
                allowBlock = YES;
                break;
            }
        }
        if (allowBlock)
        {
            block(obj, idx, stop);
        }
    }];
}

- (void)wb_enumerateArrayObjectsUsingBlock:(void (^)(NSArray *obj, NSUInteger idx, BOOL *stop))block
{
    [self wb_enumerateObjectsUsingBlock:block withCastFunction:wb_arrayOfValue];
}

- (void)wb_enumerateDictObjectsUsingBlock:(void (^)(NSDictionary *obj, NSUInteger idx, BOOL *stop))block
{
    [self wb_enumerateObjectsUsingBlock:block withCastFunction:wb_dictOfValue];
}

- (void)wb_enumerateStringObjectsUsingBlock:(void (^)(NSString *obj, NSUInteger idx, BOOL *stop))block
{
    [self wb_enumerateObjectsUsingBlock:block withCastFunction:wb_stringOfValue];
}

- (void)wb_enumerateNumberObjectsUsingBlock:(void (^)(NSNumber *obj, NSUInteger idx, BOOL *stop))block
{
    [self wb_enumerateObjectsUsingBlock:block withCastFunction:wb_numberOfValue];
}

#pragma mark - Enumerate with Options

- (void)wb_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [self enumerateObjectsWithOptions:opts usingBlock:block];
}

- (void)wb_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block withCastFunction:(id (*)(id, id))castFunction
{
    [self enumerateObjectsWithOptions:opts usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id castedObj = castFunction(obj, nil);
        if (castedObj)
        {
            block(castedObj, idx, stop);
        }
    }];
}

- (void)wb_enumerateArrayObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(NSArray *obj, NSUInteger idx, BOOL *stop))block
{
    [self wb_enumerateObjectsWithOptions:opts usingBlock:block withCastFunction:wb_arrayOfValue];
}

- (void)wb_enumerateDictObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(NSDictionary *obj, NSUInteger idx, BOOL *stop))block
{
    [self wb_enumerateObjectsWithOptions:opts usingBlock:block withCastFunction:wb_dictOfValue];
}

- (void)wb_enumerateStringObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(NSString *obj, NSUInteger idx, BOOL *stop))block
{
    [self wb_enumerateObjectsWithOptions:opts usingBlock:block withCastFunction:wb_stringOfValue];
}

- (void)wb_enumerateNumberObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(NSNumber *obj, NSUInteger idx, BOOL *stop))block
{
    [self wb_enumerateObjectsWithOptions:opts usingBlock:block withCastFunction:wb_numberOfValue];
}

@end
