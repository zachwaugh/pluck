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
#import "AFJSONRequestOperation.h"

#define CLOUDAPP_REGEX @"https?://cl\\.ly/.*"

@implementation PLKCloudAppService

+ (BOOL)isPluckableURL:(NSURL *)url
{
	return (url && [url plk_isMatchedByRegex:CLOUDAPP_REGEX]);
}

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *item, NSError *error))block
{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    
    PLKItem *item = [self itemFromDictionary:JSON];
    
    if (block) block(item, nil);
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    NSLog(@"Error fetching item for CloudApp url: %@, status: %ld, error: %@, JSON: %@", url, response.statusCode, error, JSON);
    if (block) block(nil, error);
  }];
  
  [operation start];
}

+ (PLKItem *)itemFromDictionary:(NSDictionary *)dict
{
	// We only care about image drops
	if (dict && [dict[@"item_type"] isEqualToString:@"image"]) {
		return [PLKItem itemWithDictionary:@{
						@"url": [NSURL URLWithString:dict[@"content_url"]],
						@"type": @"image",
						@"service": @"CloudApp",
						@"thumbnail": [NSURL URLWithString:dict[@"thumbnail_url"]],
						@"title": dict[@"name"]
						}];
	}
	
	return nil;
}

@end
