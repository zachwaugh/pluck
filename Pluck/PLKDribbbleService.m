//
//  PLKDribbbleService.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/18/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKDribbbleService.h"
#import "PLKItem.h"
#import "NSURL+Pluck.h"
#import "AFJSONRequestOperation.h"

//#define DRIBBBLE_REGEX @"https?://.*(dribbble\\.com|drbl\\.in)/.*"
#define DRIBBBLE_REGEX @"https?://.*dribbble\\.com/.*"

@implementation PLKDribbbleService

+ (BOOL)isSupportedURL:(NSURL *)url
{
	return (url && [url plk_isMatchedByRegex:DRIBBBLE_REGEX]);
}

+ (NSURL *)apiURLForURL:(NSURL *)url
{
  NSURL *apiURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@://api.%@%@", url.scheme, url.host, url.path]];
  
  return apiURL;
}

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *item, NSError *error))block
{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self apiURLForURL:url]];
  
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    PLKItem *item = [self itemFromDictionary:JSON];
    
    if (block) block(item, nil);
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    NSLog(@"Error fetching item for Dribbble url: %@, status: %ld, error: %@, JSON: %@", url, response.statusCode, error, JSON);
    if (block) block(nil, error);
  }];
  
  [operation start];
}

+ (PLKItem *)itemFromDictionary:(NSDictionary *)dict
{
	// We only care about image drops
	if (dict) {
		return [PLKItem itemWithDictionary:@{
						@"url": [NSURL URLWithString:dict[@"image_url"]],
						@"type": @"photo",
						@"service": @"Dribbble",
						@"title": dict[@"title"]
						}];
	}
	
	return nil;
}


@end
