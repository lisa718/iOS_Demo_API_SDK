//
//  WBResponseObject.h
//  Weibo
//
//  Created by Wade Cheng on 8/17/13.
//  Copyright (c) 2013 Sina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBResponseObject : NSObject

+ (id)responseObjectWithObject:(id)obj;
+ (id)objectWithResponseObject:(id)responseObj;

@end