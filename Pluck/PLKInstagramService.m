//
//  PLKInstagramService.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKInstagramService.h"
#import "PLKItem.h"
#import "NSURL+Pluck.h"

#define INSTAGRAM_REGEX @"https?://.*(instagram\\.com|instagr\\.am)/.*"

@implementation PLKInstagramService

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return [url plk_isMatchedByRegex:INSTAGRAM_REGEX];
}

+ (NSDictionary *)oEmbedParamsForURL:(NSURL *)url
{
	return @{ @"url": url.absoluteString };
}

+ (NSURL *)oEmbedBaseURL
{
	return [NSURL URLWithString:@"http://api.instagram.com/oembed"];
}

@end
