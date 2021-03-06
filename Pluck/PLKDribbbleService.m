//
//  PLKDribbbleService.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/18/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKDribbbleService.h"
#import "PLKItem.h"
#import "NSURL+Pluck.h"
#import "NSDictionary+Pluck.h"

#define DRIBBBLE_REGEX @"https?://.*(dribbble\\.com|drbl\\.in)/.*"

@implementation PLKDribbbleService

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return (url && [url plk_isMatchedByRegex:DRIBBBLE_REGEX]);
}

+ (NSDictionary *)oEmbedParamsForURL:(NSURL *)url
{
	return @{ @"url": url.absoluteString };
}

+ (NSURL *)oEmbedBaseURL
{
	return [NSURL URLWithString:@"http://api.dribbble.com/oembed"];
}

+ (PLKItem *)parseItemFromDictionary:(NSDictionary *)dict
{
    return [PLKItem itemWithDictionary:@{
                                         @"url": [NSURL URLWithString:dict[@"image_url"]],
                                         @"type": @"photo",
                                         @"service": @"Dribbble",
                                         @"title": [dict plk_stringForKey:@"title"]
                                         }];
}

+ (NSArray *)requiredKeys
{
	return @[ @"image_url" ];
}

@end
