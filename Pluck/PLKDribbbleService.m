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

#define DRIBBBLE_REGEX @"https?://.*(dribbble\\.com|drbl\\.in)/.*"

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

+ (void)itemForShortURL:(NSURL *)url block:(void (^)(PLKItem *item, NSError *error))block
{
  // Dribble short URLs redirect twice - http://drbl.in/gGuj > http://dribbble.com/shots/gGuj > http://dribbble.com/shots/931225-New-emoji-autocomplete-in-Flint
  // Need to wait until we get final URL and then make normal Dribbble API request
  // One issue with this approach is we request the full page, which we don't care about, should probably try to stop before final redirect
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
  AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    // Make sure we ended on a dribbble.com domain, want to avoid any sort of infinite loop
    if ([operation.response.URL.host isEqualToString:@"dribbble.com"]) {
      [self itemForURL:operation.response.URL block:block];
    } else {
      if (block) block(nil, nil);
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"error fetching url: %@ - %ld - %@", operation.request.URL, operation.response.statusCode, error);
    if (block) block(nil, error);
  }];
  
  [operation start];
}

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *item, NSError *error))block
{
  if ([url.host isEqualToString:@"drbl.in"]) {
    [self itemForShortURL:url block:block];
    return;
  }
  
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
