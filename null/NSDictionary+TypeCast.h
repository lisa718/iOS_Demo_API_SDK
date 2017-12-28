//
//  NSDictionary+TypeCast.h
//  Weibo
//
//  Created by Wade Cheng on 8/19/13.
//  Copyright (c) 2013 Sina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TypeCast)

- (BOOL)wb_hasKey:(NSString *)key;
- (id)wb_objectForKey:(NSString *)key __attribute__((deprecated));
- (id)wb_objectForKey:(NSString *)key class:(Class)clazz;

- (NSNumber *)wb_numberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue;
- (NSNumber *)wb_numberForKey:(NSString *)key;

- (NSString *)wb_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSString *)wb_stringForKey:(NSString *)key;

- (NSArray *)wb_stringArrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSArray *)wb_stringArrayForKey:(NSString *)key;

- (NSDictionary *)wb_dictForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)wb_dictForKey:(NSString *)key;
- (NSDictionary *)wb_dictionaryWithValuesForKeys:(NSArray *)keys;

- (NSArray *)wb_arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSArray *)wb_arrayForKey:(NSString *)key;

// ObjC methods to nil have undefined results for non-id values (though ints happen to currently work)
- (float)wb_floatForKey:(NSString *)key defaultValue:(float)defaultValue;
- (float)wb_floatForKey:(NSString *)key;

- (double)wb_doubleForKey:(NSString *)key defaultValue:(double)defaultValue;
- (double)wb_doubleForKey:(NSString *)key;

- (CGPoint)wb_pointForKey:(NSString *)key defaultValue:(CGPoint)defaultValue;
- (CGPoint)wb_pointForKey:(NSString *)key;

- (CGSize)wb_sizeForKey:(NSString *)key defaultValue:(CGSize)defaultValue;
- (CGSize)wb_sizeForKey:(NSString *)key;

- (CGRect)wb_rectForKey:(NSString *)key defaultValue:(CGRect)defaultValue;
- (CGRect)wb_rectForKey:(NSString *)key;

// Returns YES iff the value is YES, Y, yes, y, or 1.
- (BOOL)wb_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (BOOL)wb_boolForKey:(NSString *)key;

// Just to make life easier
- (int)wb_intForKey:(NSString *)key defaultValue:(int)defaultValue;
- (int)wb_intForKey:(NSString *)key;

- (unsigned int)wb_unsignedIntForKey:(NSString *)key defaultValue:(unsigned int)defaultValue;
- (unsigned int)wb_unsignedIntForKey:(NSString *)key;

- (NSInteger)wb_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (NSInteger)wb_integerForKey:(NSString *)key;

- (NSUInteger)wb_unsignedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)defaultValue;
- (NSUInteger)wb_unsignedIntegerForKey:(NSString *)key;

- (long long int)wb_longLongForKey:(NSString *)key defaultValue:(long long int)defaultValue;
- (long long int)wb_longLongForKey:(NSString *)key;

- (unsigned long long int)wb_unsignedLongLongForKey:(NSString *)key defaultValue:(unsigned long long int)defaultValue;
- (unsigned long long int)wb_unsignedLongLongForKey:(NSString *)key;

- (UIImage *)wb_imageForKey:(NSString *)key defaultValue:(UIImage *)defaultValue;
- (UIImage *)wb_imageForKey:(NSString *)key;

- (UIColor *)wb_colorForKey:(NSString *)key defaultValue:(UIColor *)defaultValue;
- (UIColor *)wb_colorForKey:(NSString *)key;

- (time_t)wb_timeForKey:(NSString *)key defaultValue:(time_t)defaultValue;
- (time_t)wb_timeForKey:(NSString *)key;

- (NSDate *)wb_dateForKey:(NSString *)key;

- (void)wb_enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block __attribute__((deprecated));
- (void)wb_enumerateKeysAndArrayObjectsUsingBlock:(void (^)(id key, NSArray *obj, BOOL *stop))block;
- (void)wb_enumerateKeysAndDictObjectsUsingBlock:(void (^)(id key, NSDictionary *obj, BOOL *stop))block;
- (void)wb_enumerateKeysAndStringObjectsUsingBlock:(void (^)(id key, NSString *obj, BOOL *stop))block;
- (void)wb_enumerateKeysAndNumberObjectsUsingBlock:(void (^)(id key, NSNumber *obj, BOOL *stop))block;
- (void)wb_enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block classes:(id)object, ...;

- (void)wb_enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block __attribute__((deprecated));
- (void)wb_enumerateKeysAndArrayObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, NSArray *obj, BOOL *stop))block;
- (void)wb_enumerateKeysAndDictObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, NSDictionary *obj, BOOL *stop))block;
- (void)wb_enumerateKeysAndStringObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, NSString *obj, BOOL *stop))block;
- (void)wb_enumerateKeysAndNumberObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, NSNumber *obj, BOOL *stop))block;

@end
