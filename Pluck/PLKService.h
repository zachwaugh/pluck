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

// Array of all supported services classes
+ (NSArray *)services;

// Return YES if any of the services can support this URL
+ (BOOL)isSupportedURL:(NSURL *)url;

// Return YES if any of the services passed in "services" can support this URL
// Services should be an array of classes that inherit from PLKService (i.e. - @[[PLKCloudAppService class]])
+ (BOOL)isSupportedURL:(NSURL *)url services:(NSArray *)services;

// Asynchronously returns item if one could be retrieved, or an error if not
+ (void)itemForURL:(NSURL *)url completion:(void (^)(PLKItem *item, NSError *error))block;

// Returns a item from a response dictionary, wraps parseItemFromDictionary: in some safety checks
+ (PLKItem *)itemFromDictionary:(NSDictionary *)dictionary;

// Used by service subclasses to override how item is created from response dictionary
+ (PLKItem *)parseItemFromDictionary:(NSDictionary *)dictionary;

// An array of string keys that are required to be present in response dictionary
+ (NSArray *)requiredKeys;

@end
