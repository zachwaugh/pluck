//
//  PLKService.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKService.h"
#import "PLKCloudAppService.h"
#import "PLKYoutubeService.h"
#import "PLKFlickrService.h"

NSString * const PLKErrorDomain = @"com.zachwaugh.pluck.error";

static NSArray *_services = nil;

@implementation PLKService

+ (BOOL)isPluckableURL:(NSURL *)url
{
	for (Class class in self.services) {
		if ([class isPluckableURL:url]) {
			return YES;
		}
	}
	
	return NO;
}

+ (NSArray *)services
{
	if (!_services) {
		// All services enabled by default
		_services = @[[PLKCloudAppService class], [PLKYoutubeService class], [PLKFlickrService class]];
	}

	return _services;
}

+ (void)setServices:(NSArray *)services
{
	_services = services;
}

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *item, NSError *error))block
{
	Class serviceClass = NULL;
	
	for (Class class in self.services) {
		if ([class isPluckableURL:url]) {
			serviceClass = class;
		}
	}
	
	if (serviceClass) {
		[serviceClass itemForURL:url block:block];
	} else {
		NSError *error = [NSError errorWithDomain:PLKErrorDomain code:PLKErrorUnsupportedURL userInfo:nil];
		if (block) block(nil, error);
	}
}

+ (PLKItem *)itemFromDictionary:(NSDictionary *)dict
{
	return nil;
}

@end
