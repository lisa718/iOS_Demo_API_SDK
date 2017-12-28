//
//  WBResponseObject.m
//  Weibo
//
//  Created by Wade Cheng on 8/17/13.
//  Copyright (c) 2013 Sina. All rights reserved.
//

#import "WBResponseObject.h"

@interface WBResponseObjectProxy : NSObject <NSCopying, NSCoding>
@property (nonatomic, retain) id responseObject;
+ (id)proxyWithResponseObject:(id)responseObject;
@end

@implementation WBResponseObjectProxy

@synthesize responseObject;

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init]))
	{
        id value = [decoder decodeObjectForKey:@"responseObject"];
        [self setValue:value forKey:@"responseObject"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.responseObject forKey:@"responseObject"];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
	id copied = [[[self class] alloc] init];
	[copied setValue:self.responseObject forKey:@"responseObject"];
	
	return copied;
}

+ (id)proxyWithResponseObject:(id)newResponseObject
{
    WBResponseObjectProxy *proxy = [[self alloc] init];
    proxy.responseObject = newResponseObject;
    return [proxy autorelease];
}

- (BOOL)isKindOfClass:(Class)aClass
{
    return [self.responseObject isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass
{
    return [self.responseObject isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return [self.responseObject conformsToProtocol:aProtocol];
}

- (id)throwException
{
    NSException *exception = [NSException exceptionWithName: @"WBResponseObjectException"
                                                     reason: @"为保证程序稳定性，访问WBResponseObject对象时必须指定数据类型!"
                                                   userInfo: @{@"OriginalRsponseObject": self}];
    @throw exception;
    
    return nil;
}

- (void)dealloc
{
    self.responseObject = nil;
    [super dealloc];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.responseObject;
}

- (NSString *)description
{
	return [self.responseObject description];
}

- (NSString *)debugDescription
{
	return [self.responseObject debugDescription];
}

- (BOOL)isEqual:(id)object
{
	if (object != self.class) {
		return NO;
	}
	return [self.responseObject isEqual:[object responseObject]];
}
@end

@interface WBResponseArrayProxy : WBResponseObjectProxy
@end

@implementation WBResponseArrayProxy

- (id)objectAtIndex:(NSUInteger)index
{
    return [self throwException];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    return [self throwException];
}

- (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [self throwException];
}

- (void)enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [self throwException];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
{
    [self throwException];
    return 0;
}

@end

@interface WBResponseDictionaryProxy : WBResponseObjectProxy
@end

@implementation WBResponseDictionaryProxy

- (id)objectForKeyedSubscript:(id)key
{
    return [self throwException];
}

- (id)objectForKey:(id)aKey
{
    return [self throwException];
}

- (id)valueForKey:(NSString *)key
{
    return [self throwException];
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block
{
    [self throwException];
}

- (void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block
{
    [self throwException];
}

@end

@implementation WBResponseObject : NSObject

+ (id)responseObjectWithObject:(id)obj
{
    if ([obj isKindOfClass:NSDictionary.class])
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [(NSDictionary *)obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [dict setObject:[self responseObjectWithObject:obj] forKey:key];
        }];
        return [WBResponseDictionaryProxy proxyWithResponseObject:dict];
    }
    else if ([obj isKindOfClass:NSArray.class])
    {
        NSMutableArray *array = [NSMutableArray array];
        [(NSArray *)obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [array addObject:[self responseObjectWithObject:obj]];
        }];
        return [WBResponseArrayProxy proxyWithResponseObject:array];
    }
    
    return obj;
}

+ (id)objectWithResponseObject:(id)responseObj
{
#ifdef WB_DEBUG
    if ([responseObj isKindOfClass:NSDictionary.class])
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [responseObj wb_enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [dict setObject:[self objectWithResponseObject:obj] forKey:key];
        }];
        return dict;
    }
    else if ([responseObj isKindOfClass:NSArray.class])
    {
        NSMutableArray *array = [NSMutableArray array];
        [responseObj wb_enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [array addObject:[self objectWithResponseObject:obj]];
        }];
        return array;
    }
#endif
    
    return responseObj;
}

@end