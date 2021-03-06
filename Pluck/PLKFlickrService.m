//
//  PLKFlickrService.m
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKFlickrService.h"
#import "PLKItem.h"
#import "NSURL+Pluck.h"
#import "NSDictionary+Pluck.h"

#define FLICKR_REGEX @"https?://.*(flickr\\.com/photos|flic\\.kr/p)/.*"

@implementation PLKFlickrService

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return [url plk_isMatchedByRegex:FLICKR_REGEX];
}

+ (NSURL *)oEmbedBaseURL
{
	return [NSURL URLWithString:@"http://www.flickr.com/services/oembed"];
}

+ (NSDictionary *)oEmbedParamsForURL:(NSURL *)url
{
	return @{ @"url": url.absoluteString, @"format": @"json" };
}

+ (PLKItem *)parseItemFromDictionary:(NSDictionary *)dict
{
	return [PLKItem itemWithDictionary:@{
						@"type": dict[@"type"],
						@"url": [NSURL URLWithString:dict[@"url"]],
						@"thumbnail": [NSURL URLWithString:dict[@"thumbnail_url"]],
						@"service": @"Flickr",
						@"title": dict[@"title"]
						}];
}

+ (NSArray *)requiredKeys
{
	return @[@"type", @"url", @"thumbnail_url", @"title"];
}

@end
