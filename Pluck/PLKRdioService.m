//
//  PLKRdioService.m
//  PluckDemo
//
//  Created by Zach Waugh on 4/5/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKRdioService.h"
#import "NSURL+Pluck.h"
#import "NSDictionary+Pluck.h"
#import "PLKItem.h"

#define RDIO_REGEX @"https?://.*(rdio\\.com|rd\\.io)/.*"

@implementation PLKRdioService

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return (url && [url plk_isMatchedByRegex:RDIO_REGEX]);
}

+ (NSDictionary *)oEmbedParamsForURL:(NSURL *)url
{
	return @{ @"url": url.absoluteString, @"format": @"json" };
}

+ (NSURL *)oEmbedBaseURL
{
	return [NSURL URLWithString:@"http://www.rdio.com/api/oembed/"];
}

+ (PLKItem *)parseItemFromDictionary:(NSDictionary *)dict
{
  return [PLKItem itemWithDictionary:@{
   @"url": [NSURL URLWithString:dict[@"thumbnail_url"]],
   @"type": @"photo",
   @"service": @"Rdio",
   @"title": [dict plk_stringForKey:@"title"],
   @"html": [dict plk_stringForKey:@"html"]
   }];
}

+ (NSArray *)requiredKeys
{
	return @[@"thumbnail_url"];
}

@end
