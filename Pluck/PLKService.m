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

NSString * const PLKErrorDomain = @"com.zachwaugh.pluck.error";

@implementation PLKService

+ (NSArray *)services
{
	static NSArray *_services = nil;
	if (!_services) {
		// All services enabled by default - may add option to modify in the future
		_services = @[[PLKCloudAppService class], [PLKYoutubeService class], [PLKFlickrService class], [PLKVimeoService class]];
	}
	
	return _services;
}

+ (BOOL)isPluckableURL:(NSURL *)url
{
	// Check all service classes to find a service that can support this URL
	for (Class class in self.services) {
		if ([class isPluckableURL:url]) {
			return YES;
		}
	}
	
	return NO;
}

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *item, NSError *error))block
{
	Class serviceClass = nil;
	
	for (Class class in self.services) {
		if ([class isPluckableURL:url]) {
			serviceClass = class;
		}
	}
	
	if (serviceClass) {
		[serviceClass itemForURL:url block:block];
	} else {
		// No service found - return unsupported URL error
		NSError *error = [NSError errorWithDomain:PLKErrorDomain code:PLKErrorUnsupportedURL userInfo:nil];
		if (block) block(nil, error);
	}
}

+ (PLKItem *)itemFromDictionary:(NSDictionary *)dict
{
	return nil;
}

@end
