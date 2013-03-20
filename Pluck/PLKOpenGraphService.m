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
#import "NSDictionary+Pluck.h"

@implementation PLKOpenGraphService

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *, NSError *))block
{
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		PLKItem *item = [self itemFromDictionary:[self openGraphAttributesFromHTMLData:responseObject]];
		
		if (block) block(item, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) block(nil, error);
	}];
	
	[operation start];
}

+ (NSDictionary *)openGraphAttributesFromHTMLData:(NSData *)data
{
	TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
	NSArray *metaTags = [doc searchWithXPathQuery:@"/html/head/meta"];

	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	for (TFHppleElement *element in metaTags) {
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
					@"url": [NSURL URLWithString:dict[@"image"]],
					@"service": [dict plk_stringForKey:@"site_name"],
					@"title": [dict plk_stringForKey:@"title"],
          @"description": [dict plk_stringForKey:@"description"],
					@"type": @"photo"
         }];
}

@end
