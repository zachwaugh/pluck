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

NSString * const PLKErrorDomain = @"com.zachwaugh.pluck.error";

@implementation PLKService

+ (NSArray *)services
{
	static NSArray *_services = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_services = @[[PLKCloudAppService class], [PLKYoutubeService class], [PLKFlickrService class], [PLKVimeoService class], [PLKInstagramService class], [PLKDribbbleService class], [PLKDroplrService class]];
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

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *item, NSError *error))block
{
	Class serviceClass = nil;
	
	for (Class class in self.services) {
		if ([class isSupportedURL:url]) {
			serviceClass = class;
			break;
		}
	}
	
	if (serviceClass) {
		[serviceClass itemForURL:url block:block];
	} else {
		// No service found that supports this URL - return unsupported URL error
		NSError *error = [NSError errorWithDomain:PLKErrorDomain code:PLKErrorUnsupportedURL userInfo:nil];
		if (block) block(nil, error);
	}
}

+ (PLKItem *)itemFromDictionary:(NSDictionary *)dict
{
	return nil;
}

@end
