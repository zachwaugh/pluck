//
//  PLKOEmbedService.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/17/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKOEmbedService.h"
#import "PLKItem.h"
#import "NSDictionary+Pluck.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@implementation PLKOEmbedService

+ (NSDictionary *)oEmbedParamsForURL:(NSURL *)url
{
	return nil;
}

+ (NSURL *)oEmbedBaseURL
{
    // Must implement in subclass
	return nil;
}

+ (void)itemForURL:(NSURL *)url completion:(void (^)(PLKItem *, NSError *))block
{
    AFHTTPRequestOperationManager *client = [AFHTTPRequestOperationManager manager];
	NSDictionary *params = [self oEmbedParamsForURL:url];

    [client GET:self.oEmbedBaseURL.absoluteString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
		PLKItem *item = [self itemFromDictionary:responseObject];

		if (block) block(item, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(nil, error);
    }];
}

+ (PLKItem *)parseItemFromDictionary:(NSDictionary *)dict
{
  return [PLKItem itemWithDictionary:@{
          @"type": dict[@"type"],
          @"url": [NSURL URLWithString:dict[@"url"]],
          @"service": dict[@"provider_name"],
          @"title": dict[@"title"]
          }];
}

+ (NSArray *)requiredKeys
{
	return @[ @"type", @"url", @"provider_name", @"title" ];
}

@end
