//
//  NSDictionary+TypeCast.m
//  Weibo
//
//  Created by Wade Cheng on 8/19/13.
//  Copyright (c) 2013 Sina. All rights reserved.
//

#import "NSDictionary+TypeCast.h"
#import "NSString+SimpleMatching.h"
#import "TypeCastUtil.h"

#define OFK [self objectForKey:key]

@implementation NSDictionary (TypeCast)

- (BOOL)wb_hasKey:(NSString *)key
{
    return (OFK != nil);
}

#pragma mark - NSObject

- (id)wb_objectForKey:(NSString *)key
{
    return OFK;
}

- (id)wb_objectForKey:(NSString *)key class:(Class)clazz
{
    id obj = OFK;
    if ([obj isKindOfClass:clazz])
    {
        return obj;
    }
    
    return nil;
}

#pragma mark - NSNumber

- (NSNumber *)wb_numberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue
{
    return wb_numberOfValue(OFK, defaultValue);
}

- (NSNumber *)wb_numberForKey:(NSString *)key
{
	return [self wb_numberForKey:key defaultValue:nil];
}

#pragma mark - NSString

- (NSString *)wb_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
{
    return wb_stringOfValue(OFK, defaultValue);
}

- (NSString *)wb_stringForKey:(NSString *)key;
{
    return [self wb_stringForKey:key defaultValue:nil];
}

#pragma mark - NSArray of NSString

- (NSArray *)wb_stringArrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue
{
    return wb_stringArrayOfValue(OFK, defaultValue);
}

- (NSArray *)wb_stringArrayForKey:(NSString *)key;
{
    return [self wb_stringArrayForKey:key defaultValue:nil];
}

#pragma mark - NSDictionary

- (NSDictionary *)wb_dictForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue
{
    return wb_dictOfValue(OFK, defaultValue);
}

- (NSDictionary *)wb_dictForKey:(NSString *)key
{
    return [self wb_dictForKey:key defaultValue:nil];
}

- (NSDictionary *)wb_dictionaryWithValuesForKeys:(NSArray *)keys
{
    return [self dictionaryWithValuesForKeys:keys];
}

#pragma mark - NSArray

- (NSArray *)wb_arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue
{
    return wb_arrayOfValue(OFK, defaultValue);
}

- (NSArray *)wb_arrayForKey:(NSString *)key
{
    return [self wb_arrayForKey:key defaultValue:nil];
}

#pragma mark - Float

- (float)wb_floatForKey:(NSString *)key defaultValue:(float)defaultValue;
{
    return wb_floatOfValue(OFK, defaultValue);
}

- (float)wb_floatForKey:(NSString *)key;
{
    return [self wb_floatForKey:key defaultValue:0.0f];
}

#pragma mark - Double

- (double)wb_doubleForKey:(NSString *)key defaultValue:(double)defaultValue;
{
    return wb_doubleOfValue(OFK, defaultValue);
}

- (double)wb_doubleForKey:(NSString *)key;
{
    return [self wb_doubleForKey:key defaultValue:0.0];
}

#pragma mark - CGPoint

- (CGPoint)wb_pointForKey:(NSString *)key defaultValue:(CGPoint)defaultValue
{
    return wb_pointOfValue(OFK, defaultValue);
}

- (CGPoint)wb_pointForKey:(NSString *)key;
{
    return [self wb_pointForKey:key defaultValue:NSZeroPoint];
}

#pragma mark - CGSize

- (CGSize)wb_sizeForKey:(NSString *)key defaultValue:(CGSize)defaultValue;
{
    return wb_sizeOfValue(OFK, defaultValue);
}

- (CGSize)wb_sizeForKey:(NSString *)key;
{
    return [self wb_sizeForKey:key defaultValue:NSZeroSize];
}

#pragma mark - CGRect

- (CGRect)wb_rectForKey:(NSString *)key defaultValue:(CGRect)defaultValue;
{
    return wb_rectOfValue(OFK, defaultValue);
}

- (CGRect)wb_rectForKey:(NSString *)key;
{
    return [self wb_rectForKey:key defaultValue:NSZeroRect];
}

#pragma mark - BOOL

- (BOOL)wb_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
{
    return wb_boolOfValue(OFK, defaultValue);
}

- (BOOL)wb_boolForKey:(NSString *)key;
{
    return [self wb_boolForKey:key defaultValue:NO];
}

#pragma mark - Int

- (int)wb_intForKey:(NSString *)key defaultValue:(int)defaultValue;
{
    return wb_intOfValue(OFK, defaultValue);
}

- (int)wb_intForKey:(NSString *)key;
{
    return [self wb_intForKey:key defaultValue:0];
}

#pragma mark - Unsigned Int

- (unsigned int)wb_unsignedIntForKey:(NSString *)key defaultValue:(unsigned int)defaultValue;
{
    return wb_unsignedIntOfValue(OFK, defaultValue);
}

- (unsigned int)wb_unsignedIntForKey:(NSString *)key;
{
    return [self wb_unsignedIntForKey:key defaultValue:0];
}

#pragma mark - Long Long

- (long long int)wb_longLongForKey:(NSString *)key defaultValue:(long long int)defaultValue
{
    return wb_longLongOfValue(OFK, defaultValue);
}

- (long long int)wb_longLongForKey:(NSString *)key;
{
    return [self wb_longLongForKey:key defaultValue:0LL];
}

#pragma mark - Unsigned Long Long

- (unsigned long long int)wb_unsignedLongLongForKey:(NSString *)key defaultValue:(unsigned long long int)defaultValue;
{
    return wb_unsignedLongLongOfValue(OFK, defaultValue);
}

- (unsigned long long int)wb_unsignedLongLongForKey:(NSString *)key;
{
    return [self wb_unsignedLongLongForKey:key defaultValue:0ULL];
}

#pragma mark - NSInteger

- (NSInteger)wb_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
{
    return wb_integerOfValue(OFK, defaultValue);
}

- (NSInteger)wb_integerForKey:(NSString *)key;
{
    return [self wb_integerForKey:key defaultValue:0];
}

#pragma mark - Unsigned Integer

- (NSUInteger)wb_unsignedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)defaultValue
{
	return wb_unsignedIntegerOfValue(OFK, defaultValue);
}

- (NSUInteger)wb_unsignedIntegerForKey:(NSString *)key
{
	return [self wb_unsignedIntegerForKey:key defaultValue:0];
}

#pragma mark - UIImage

- (UIImage *)wb_imageForKey:(NSString *)key defaultValue:(UIImage *)defaultValue
{
    return wb_imageOfValue(OFK, defaultValue);
}

- (UIImage *)wb_imageForKey:(NSString *)key
{
	return [self wb_imageForKey:key defaultValue:nil];
}

#pragma mark - UIColor

- (UIColor *)wb_colorForKey:(NSString *)key defaultValue:(UIColor *)defaultValue
{
    return wb_colorOfValue(OFK, defaultValue);
}

- (UIColor *)wb_colorForKey:(NSString *)key
{
	return [self wb_colorForKey:key defaultValue:[UIColor whiteColor]];
}

#pragma mark - Time

- (time_t)wb_timeForKey:(NSString *)key defaultValue:(time_t)defaultValue
{
    return wb_timeOfValue(OFK, defaultValue);
}

- (time_t)wb_timeForKey:(NSString *)key
{
    time_t defaultValue = [[NSDate date] timeIntervalSince1970];
    return [self wb_timeForKey:key defaultValue:defaultValue];
}

#pragma mark - NSDate

- (NSDate *)wb_dateForKey:(NSString *)key
{
    return wb_dateOfValue(OFK);
}

#pragma mark - Enumerate

- (void)wb_enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block
{
    [self enumerateKeysAndObjectsUsingBlock:block];
}

- (void)wb_enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block withCastFunction:(id (*)(id, id))castFunction
{
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id castedObj = castFunction(obj, nil);
        if (castedObj)
        {
            block(key, castedObj, stop);
        }
    }];
}

- (void)wb_enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block classes:(id)object, ...
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
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
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
            block(key, obj, stop);
        }
    }];
}

- (void)wb_enumerateKeysAndArrayObjectsUsingBlock:(void (^)(id key, NSArray *obj, BOOL *stop))block
{
    [self wb_enumerateKeysAndObjectsUsingBlock:block withCastFunction:wb_arrayOfValue];
}

- (void)wb_enumerateKeysAndDictObjectsUsingBlock:(void (^)(id key, NSDictionary *obj, BOOL *stop))block
{
    [self wb_enumerateKeysAndObjectsUsingBlock:block withCastFunction:wb_dictOfValue];
}

- (void)wb_enumerateKeysAndStringObjectsUsingBlock:(void (^)(id key, NSString *obj, BOOL *stop))block
{
    [self wb_enumerateKeysAndObjectsUsingBlock:block withCastFunction:wb_stringOfValue];
}

- (void)wb_enumerateKeysAndNumberObjectsUsingBlock:(void (^)(id key, NSNumber *obj, BOOL *stop))block
{
    [self wb_enumerateKeysAndObjectsUsingBlock:block withCastFunction:wb_numberOfValue];
}

#pragma mark - Enumerate with Options

- (void)wb_enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block
{
    [self enumerateKeysAndObjectsWithOptions:opts usingBlock:block];
}

- (void)wb_enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block withCastFunction:(id (*)(id, id))castFunction
{
    [self enumerateKeysAndObjectsWithOptions:opts usingBlock:^(id key, id obj, BOOL *stop) {
        id castedObj = castFunction(obj, nil);
        if (castedObj)
        {
            block(key, castedObj, stop);
        }
    }];
}

- (void)wb_enumerateKeysAndArrayObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, NSArray *obj, BOOL *stop))block
{
    [self wb_enumerateKeysAndObjectsWithOptions:opts usingBlock:block withCastFunction:wb_arrayOfValue];
}

- (void)wb_enumerateKeysAndDictObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, NSDictionary *obj, BOOL *stop))block
{
    [self wb_enumerateKeysAndObjectsWithOptions:opts usingBlock:block withCastFunction:wb_dictOfValue];
}

- (void)wb_enumerateKeysAndStringObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, NSString *obj, BOOL *stop))block
{
    [self wb_enumerateKeysAndObjectsWithOptions:opts usingBlock:block withCastFunction:wb_stringOfValue];
}

- (void)wb_enumerateKeysAndNumberObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, NSNumber *obj, BOOL *stop))block
{
    [self wb_enumerateKeysAndObjectsWithOptions:opts usingBlock:block withCastFunction:wb_numberOfValue];
}


@end
