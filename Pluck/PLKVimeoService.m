//
//  PLKVimeoService.m
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKVimeoService.h"
#import "PLKItem.h"
#import "AFHTTPClient.h"
#import "NSURL+Pluck.h"

#define VIMEO_REGEX @"https?://.*vimeo\\.com/.*"

@implementation PLKVimeoService

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return [url plk_isMatchedByRegex:VIMEO_REGEX];
}

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *, NSError *))block
{
	AFHTTPClient *flickrClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://vimeo.com/"]];
	NSDictionary *params = @{ @"url": url.absoluteString};
	
	[flickrClient getPath:@"api/oembed.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSError *error = nil;
		NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
		
		if (error) {
			NSLog(@"error creating json from response: %@", error);
		}
		
		PLKItem *item = [self itemFromDictionary:dict];
		if (block) block(item, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) block(nil, error);
	}];
}

+ (PLKItem *)itemFromDictionary:(NSDictionary *)dict
{
	if (dict) {
		return [PLKItem itemWithDictionary:@{
						@"type": dict[@"type"],
						@"url": [NSURL URLWithString:dict[@"thumbnail_url"]],
						@"thumbnail": [NSURL URLWithString:dict[@"thumbnail_url"]],
						@"html": dict[@"html"],
						@"service": @"Vimeo",
						@"title": dict[@"title"]
						}];
	}
	
	return nil;
}

@end
