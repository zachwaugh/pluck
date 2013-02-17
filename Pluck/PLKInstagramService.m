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
#import "AFHTTPClient.h"

#define INSTAGRAM_REGEX @"https?://.*(instagram\\.com|instagr\\.am)/.*"

@implementation PLKInstagramService

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return [url plk_isMatchedByRegex:INSTAGRAM_REGEX];
}

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *, NSError *))block
{
	AFHTTPClient *instagramClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.instagram.com/"]];
	NSDictionary *params = @{ @"url": url.absoluteString};
	
	[instagramClient getPath:@"oembed" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
						@"service": dict[@"provider_name"],
						@"title": dict[@"title"]
						}];
	}
	
	return nil;
}

@end
