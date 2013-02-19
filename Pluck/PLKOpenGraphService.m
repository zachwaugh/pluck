//
//  PLKOpenGraphService.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/18/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKOpenGraphService.h"
#import "PLKItem.h"
#import "AFHTTPRequestOperation.h"
#import "TFHpple.h"

@implementation PLKOpenGraphService

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *, NSError *))block
{
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		TFHpple *doc = [[TFHpple alloc] initWithHTMLData:responseObject];
		NSArray *metaTags = [doc searchWithXPathQuery:@"//meta"];
		PLKItem *item = [self itemFromDictionary:[self openGraphAttributesFromTags:metaTags]];
		
		if (block) block(item, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) block(nil, error);
	}];
	
	[operation start];
}

+ (NSDictionary *)openGraphAttributesFromTags:(NSArray *)tags
{
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	for (TFHppleElement *element in tags) {
		NSString *property = element.attributes[@"property"];
		if (property && [property hasPrefix:@"og:"]) {
			NSString *ogProperty = [property substringFromIndex:3];
			NSString *content = element.attributes[@"content"];
			dict[ogProperty] = content;
		}
	}

	NSLog(@"openGraph attributes: %@", dict);
	
	return dict;
}

+ (PLKItem *)itemFromDictionary:(NSDictionary *)dict
{
	return [PLKItem itemWithDictionary:@{
					@"url": dict[@"url"],
					@"service": dict[@"site_name"],
					@"title": dict[@"title"]
					}];
}

@end
