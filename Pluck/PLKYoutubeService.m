//
//  PLKYoutubeService.m
//  PluckDemo
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

+ (BOOL)isPluckableURL:(NSURL *)url
{
	return [url plk_isMatchedByRegex:YOUTUBE_REGEX];
}

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *, NSError *))block
{
	AFHTTPClient *youtubeClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.youtube.com/"]];
	
	NSDictionary *params = @{ @"url": url.absoluteString, @"format": @"json" };
	
	[youtubeClient getPath:@"oembed" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSError *error = nil;
		NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
		
		if (error) {
			NSLog(@"error creating json from response: %@", error);
		}
		
		NSLog(@"youtube response: %@", dict);
		
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
						@"type": @"video",
						@"url": [NSURL URLWithString:dict[@"thumbnail_url"]],
						@"service": @"YouTube",
						@"title": dict[@"title"]
					 }];
	}
	
	return nil;
}

@end
