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
#import "AFHTTPClient.h"

#define FLICKR_REGEX @"https?://.*(flickr\\.com/photos|flic\\.kr/p)/.*"

@implementation PLKFlickrService

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return [url plk_isMatchedByRegex:FLICKR_REGEX];
}

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *, NSError *))block
{
	AFHTTPClient *flickrClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.flickr.com/"]];
	NSDictionary *params = @{ @"url": url.absoluteString, @"format": @"json" };
	
	[flickrClient getPath:@"services/oembed/" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
						@"url": [NSURL URLWithString:dict[@"url"]],
						@"thumbnail": [NSURL URLWithString:dict[@"thumbnail_url"]],
						@"service": @"Flickr",
						@"title": dict[@"title"]
						}];
	}
	
	return nil;
}

@end
