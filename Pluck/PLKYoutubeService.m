//
//  PLKYoutubeService.m
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKYoutubeService.h"
#import "PLKItem.h"
#import "NSURL+Pluck.h"
#import "NSDictionary+Pluck.h"

#define YOUTUBE_REGEX @"https?://.*(youtube\\.com|youtu\\.be)/.*"

@implementation PLKYoutubeService

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return [url plk_isMatchedByRegex:YOUTUBE_REGEX];
}

+ (NSURL *)oEmbedBaseURL
{
	return [NSURL URLWithString:@"http://www.youtube.com/oembed"];
}

+ (NSDictionary *)oEmbedParamsForURL:(NSURL *)url
{
	return @{ @"url": url.absoluteString, @"format": @"json" };
}

+ (PLKItem *)parseItemFromDictionary:(NSDictionary *)dict
{
	return [PLKItem itemWithDictionary:@{
						@"type": [dict plk_stringForKey:@"type"],
						@"url": [NSURL URLWithString:dict[@"thumbnail_url"]],
						@"html": [dict plk_stringForKey:@"html"],
						@"service": @"YouTube",
						@"title": [dict plk_stringForKey:@"title"]
					 }];
}


+ (NSArray *)requiredKeys
{
	return @[@"type", @"thumbnail_url"];
}

@end
