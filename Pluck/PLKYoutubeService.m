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
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

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

+ (PLKItem *)itemFromDictionary:(NSDictionary *)dict
{
  if (!dict || dict.count == 0) return nil;
  
	return [PLKItem itemWithDictionary:@{
						@"type": dict[@"type"],
						@"url": [NSURL URLWithString:dict[@"thumbnail_url"]],
						@"html": dict[@"html"],
						@"service": dict[@"provider_name"],
						@"title": dict[@"title"]
					 }];
}

@end
