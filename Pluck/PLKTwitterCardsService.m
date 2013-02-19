//
//  PLKTwitterCardsService.m
//  Pluck
//
//  Created by Zach Waugh on 2/18/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKTwitterCardsService.h"
#import "PLKItem.h"
#import "AFHTTPRequestOperation.h"
#import "TFHpple.h"

@implementation PLKTwitterCardsService

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
		NSString *name = element.attributes[@"name"];
		if (name && [name hasPrefix:@"twitter:"]) {
			NSString *ogName = [name substringFromIndex:8];
			NSString *content = element.attributes[@"content"];
			dict[ogName] = content;
		}
	}
	
	NSLog(@"Twitter card attributes: %@", dict);
	
	return dict;
}

+ (PLKItem *)itemFromDictionary:(NSDictionary *)dict
{
	return [PLKItem itemWithDictionary:@{
					@"url": dict[@"image"],
					@"service": dict[@"site"],
					@"title": dict[@"title"],
					@"type": dict[@"card"]
					}];
}

@end
