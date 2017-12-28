//
//  NSArray+TypeCast.h
//  Weibo
//
//  Created by Wade Cheng on 8/19/13.
//  Copyright (c) 2013 Sina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (TypeCast)

- (id)wb_objectAtIndex:(NSUInteger)index  __attribute__((deprecated));

- (NSNumber *)wb_numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)defaultValue;
- (NSNumber *)wb_numberAtIndex:(NSUInteger)index;

- (NSString *)wb_stringAtIndex:(NSUInteger)index defaultValue:(NSString *)defaultValue;
- (NSString *)wb_stringAtIndex:(NSUInteger)index;

- (NSArray *)wb_stringArrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue;
- (NSArray *)wb_stringArrayAtIndex:(NSUInteger)index;

- (NSDictionary *)wb_dictAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)wb_dictAtIndex:(NSUInteger)index;

- (NSArray *)wb_arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue;
- (NSArray *)wb_arrayAtIndex:(NSUInteger)index;

- (float)wb_floatAtIndex:(NSUInteger)index defaultValue:(float)defaultValue;
- (float)wb_floatAtIndex:(NSUInteger)index;

- (double)wb_doubleAtIndex:(NSUInteger)index defaultValue:(double)defaultValue;
- (double)wb_doubleAtIndex:(NSUInteger)index;

- (CGPoint)wb_pointAtIndex:(NSUInteger)index defaultValue:(CGPoint)defaultValue;
- (CGPoint)wb_pointAtIndex:(NSUInteger)index;

- (CGSize)wb_sizeAtIndex:(NSUInteger)index defaultValue:(CGSize)defaultValue;
- (CGSize)wb_sizeAtIndex:(NSUInteger)index;

- (CGRect)wb_rectAtIndex:(NSUInteger)index defaultValue:(CGRect)defaultValue;
- (CGRect)wb_rectAtIndex:(NSUInteger)index;

- (BOOL)wb_boolAtIndex:(NSUInteger)index defaultValue:(BOOL)defaultValue;
- (BOOL)wb_boolAtIndex:(NSUInteger)index;

- (int)wb_intAtIndex:(NSUInteger)index defaultValue:(int)defaultValue;
- (int)wb_intAtIndex:(NSUInteger)index;

- (unsigned int)wb_unsignedIntAtIndex:(NSUInteger)index defaultValue:(unsigned int)defaultValue;
- (unsigned int)wb_unsignedIntAtIndex:(NSUInteger)index;

- (NSInteger)wb_integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)defaultValue;
- (NSInteger)wb_integerAtIndex:(NSUInteger)index;

- (NSUInteger)wb_unsignedIntegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)defaultValue;
- (NSUInteger)wb_unsignedIntegerAtIndex:(NSUInteger)index;

- (long long int)wb_longLongAtIndex:(NSUInteger)index defaultValue:(long long int)defaultValue;
- (long long int)wb_longLongAtIndex:(NSUInteger)index;

- (unsigned long long int)wb_unsignedLongLongAtIndex:(NSUInteger)index defaultValue:(unsigned long long int)defaultValue;
- (unsigned long long int)wb_unsignedLongLongAtIndex:(NSUInteger)index;

- (UIImage *)wb_imageAtIndex:(NSUInteger)index defaultValue:(UIImage *)defaultValue;
- (UIImage *)wb_imageAtIndex:(NSUInteger)index;

- (UIColor *)wb_colorAtIndex:(NSUInteger)index defaultValue:(UIColor *)defaultValue;
- (UIColor *)wb_colorAtIndex:(NSUInteger)index;

- (time_t)wb_timeAtIndex:(NSUInteger)index defaultValue:(time_t)defaultValue;
- (time_t)wb_timeAtIndex:(NSUInteger)index;

- (NSDate *)wb_dateAtIndex:(NSUInteger)index;

- (void)wb_enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block __attribute__((deprecated));
- (void)wb_enumerateArrayObjectsUsingBlock:(void (^)(NSArray *obj, NSUInteger idx, BOOL *stop))block;
- (void)wb_enumerateDictObjectsUsingBlock:(void (^)(NSDictionary *obj, NSUInteger idx, BOOL *stop))block;
- (void)wb_enumerateStringObjectsUsingBlock:(void (^)(NSString *obj, NSUInteger idx, BOOL *stop))block;
- (void)wb_enumerateNumberObjectsUsingBlock:(void (^)(NSNumber *obj, NSUInteger idx, BOOL *stop))block;
- (void)wb_enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block classes:(id)object, ...;

- (void)wb_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block __attribute__((deprecated));
- (void)wb_enumerateArrayObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(NSArray *obj, NSUInteger idx, BOOL *stop))block;
- (void)wb_enumerateDictObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(NSDictionary *obj, NSUInteger idx, BOOL *stop))block;
- (void)wb_enumerateStringObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(NSString *obj, NSUInteger idx, BOOL *stop))block;
- (void)wb_enumerateNumberObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(NSNumber *obj, NSUInteger idx, BOOL *stop))block;
@end