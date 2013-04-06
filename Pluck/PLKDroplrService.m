//
//  PLKDroplrService.m
//  PluckDemo
//
//  Created by Zach Waugh on 3/20/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKDroplrService.h"
#import "PLKItem.h"
#import "NSURL+Pluck.h"
#import "NSDictionary+Pluck.h"

#define DROPLR_REGEX @"https?://d\\.pr/i/.*"

@implementation PLKDroplrService

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return (url && [url plk_isMatchedByRegex:DROPLR_REGEX]);
}

+ (PLKItem *)parseItemFromDictionary:(NSDictionary *)dict
{
	return [PLKItem itemWithDictionary:@{
					@"url": [NSURL URLWithString:dict[@"image"]],
					@"title": [dict plk_stringForKey:@"title"],
          @"description": [dict plk_stringForKey:@"description"],
          @"service": @"Droplr",
					@"type": @"photo"
          }];
}

+ (NSArray *)requiredKeys
{
	return @[@"image"];
}

@end
