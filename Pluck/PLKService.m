//
//  PLKService.m
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKService.h"
#import "PLKCloudAppService.h"
#import "PLKYoutubeService.h"
#import "PLKFlickrService.h"
#import "PLKVimeoService.h"
#import "PLKInstagramService.h"
#import "PLKDribbbleService.h"
#import "PLKDroplrService.h"
#import "PLKRdioService.h"
#import "NSDictionary+Pluck.h"

NSString * const PLKErrorDomain = @"com.zachwaugh.pluck.error";

@implementation PLKService

+ (NSArray *)services
{
	static NSArray *_services = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		// All services supported by default
		_services = @[[PLKCloudAppService class], [PLKYoutubeService class], [PLKFlickrService class], [PLKVimeoService class], [PLKInstagramService class], [PLKDribbbleService class], [PLKDroplrService class], [PLKRdioService class]];
	});
	
	return _services;
}

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return [self isSupportedURL:url services:[self services]];
}

+ (BOOL)isSupportedURL:(NSURL *)url services:(NSArray *)services
{
	for (Class class in services) {
		if ([class isSupportedURL:url]) {
			return YES;
		}
	}
	
	return NO;
}

+ (void)itemForURL:(NSURL *)url completion:(void (^)(PLKItem *item, NSError *error))block
{
	Class serviceClass = nil;
	
	for (Class class in self.services) {
		if ([class isSupportedURL:url]) {
			serviceClass = class;
			break;
		}
	}
	
	if (serviceClass) {
		[serviceClass itemForURL:url completion:block];
	} else {
		// No service found that supports this URL - return unsupported URL error
		NSError *error = [NSError errorWithDomain:PLKErrorDomain code:PLKErrorUnsupportedURL userInfo:nil];
		if (block) block(nil, error);
	}
}

+ (PLKItem *)itemFromDictionary:(NSDictionary *)dict
{
	// We try to be extra defensive here, we don't want a missing key or a change in the response to possibly cause a crash in the client
    if (!dict || dict.count == 0 || ![dict plk_hasValuesForKeys:[self requiredKeys]]) return nil;
    
    PLKItem *item = nil;
    
    @try {
        item = [self parseItemFromDictionary:dict];
    }
    @catch (NSException *exception) {
        NSLog(@"[%@] itemFromDictionary: %@, exception: %@", self, dict, exception);
    }
    
	return item;
}

+ (PLKItem *)parseItemFromDictionary:(NSDictionary *)dict
{
    // Implement in subclass
    return nil;
}

+ (NSArray *)requiredKeys
{
	// Implement in subclass, array of keys that must present in response dictionary
	return @[];
}

@end
