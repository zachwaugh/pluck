//
//  PLKService.h
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const PLKErrorDomain;

enum {
  PLKErrorUnknown = -1,
  PLKErrorUnsupportedURL = 0
};

@class PLKItem;

@interface PLKService : NSObject

+ (NSArray *)services;

+ (BOOL)isSupportedURL:(NSURL *)url;
+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *item, NSError *error))block;
+ (PLKItem *)itemFromDictionary:(NSDictionary *)dictionary;

@end
