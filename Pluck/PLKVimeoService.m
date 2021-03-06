//
//  PLKVimeoService.m
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKVimeoService.h"
#import "PLKItem.h"
#import "NSURL+Pluck.h"
#import "NSDictionary+Pluck.h"

#define VIMEO_REGEX @"https?://.*vimeo\\.com/.*"

@implementation PLKVimeoService

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return [url plk_isMatchedByRegex:VIMEO_REGEX];
}

+ (NSURL *)oEmbedBaseURL
{
	return [NSURL URLWithString:@"http://vimeo.com/api/oembed.json"];
}

+ (NSDictionary *)oEmbedParamsForURL:(NSURL *)url
{
	return @{ @"url": url.absoluteString };
}

+ (PLKItem *)parseItemFromDictionary:(NSDictionary *)dict
{
	return [PLKItem itemWithDictionary:@{
                                         @"type": [dict plk_stringForKey:@"type"],
                                         @"url": [NSURL URLWithString:dict[@"thumbnail_url"]],
                                         @"thumbnail": [NSURL URLWithString:dict[@"thumbnail_url"]],
                                         @"html": [dict plk_stringForKey:@"html"],
                                         @"service": @"Vimeo",
                                         @"title": [dict plk_stringForKey:@"title"]
                                         }];
}

+ (NSArray *)requiredKeys
{
	return @[@"thumbnail_url", @"type", @"title"];
}

@end
