//
//  PLKCloudAppService.m
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKCloudAppService.h"
#import "PLKItem.h"
#import "NSURL+Pluck.h"
#import "NSDictionary+Pluck.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

#define CLOUDAPP_REGEX @"https?://cl\\.ly/.*"

@implementation PLKCloudAppService

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return (url && [url plk_isMatchedByRegex:CLOUDAPP_REGEX]);
}

+ (void)itemForURL:(NSURL *)url completion:(void (^)(PLKItem *item, NSError *error))block
{
    AFHTTPRequestOperationManager *client = [AFHTTPRequestOperationManager manager];
    [client.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    [client GET:url.absoluteString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        PLKItem *item = [self itemFromDictionary:responseObject];
        
        if (block) block(item, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error fetching item for CloudApp url: %@, status: %ld, error: %@, JSON: %@", url, operation.response.statusCode, error, operation.responseString);
        if (block) block(nil, error);
    }];
}

+ (PLKItem *)parseItemFromDictionary:(NSDictionary *)dict
{
	// We only care about image drops currently
  if (![dict[@"item_type"] isEqualToString:@"image"]) return nil;

  return [PLKItem itemWithDictionary:@{
          @"url": [NSURL URLWithString:dict[@"content_url"]],
          @"type": @"photo",
          @"service": @"CloudApp",
          @"thumbnail": [NSURL URLWithString:dict[@"thumbnail_url"]],
          @"title": dict[@"name"]
          }];
}

+ (NSArray *)requiredKeys
{
	return @[ @"content_url", @"thumbnail_url", @"name", @"item_type" ];
}

@end
