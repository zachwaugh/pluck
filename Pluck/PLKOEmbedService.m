//
//  PLKOEmbedService.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/17/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKOEmbedService.h"
#import "PLKItem.h"
#import "AFHTTPClient.h"

@implementation PLKOEmbedService

+ (NSDictionary *)oEmbedParamsForURL:(NSURL *)url
{
	return nil;
}

+ (NSURL *)oEmbedBaseURL
{
	return nil;
}

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *, NSError *))block
{
	AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[self oEmbedBaseURL]];
	NSDictionary *params = [self oEmbedParamsForURL:url];

	[client getPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSError *error = nil;
		NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
		PLKItem *item = nil;
		
		if (!error) {
			NSLog(@"oEmbed response: %@", dict);
			item = [self itemFromDictionary:dict];
		} else {
			NSLog(@"error creating json from response: %@", error);
		}
		
		if (block) block(item, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) block(nil, error);
	}];
}

+ (PLKItem *)itemFromDictionary:(NSDictionary *)dict
{
	if (dict) {
		NSDictionary *itemDict = @{
			@"type": dict[@"type"],
			@"url": [NSURL URLWithString:dict[@"url"]],
			@"service": dict[@"provider_name"],
			@"title": dict[@"title"]
		};
		
		return [PLKItem itemWithDictionary:itemDict];
	}
	
	return nil;
}

@end
