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
#import "NSDictionary+Pluck.h"

@implementation PLKTwitterCardsService

+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *, NSError *))block
{
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		PLKItem *item = [self itemFromDictionary:[self twitterCardsAttributesFromHTMLData:responseObject]];
		
		if (block) block(item, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) block(nil, error);
	}];
	
	[operation start];
}

+ (NSDictionary *)twitterCardsAttributesFromHTMLData:(NSData *)data
{
	TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
	NSArray *metaTags = [doc searchWithXPathQuery:@"/html/head/meta"];
	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	// Seems to be a lack of standardization with tag attributes, I've seen meta tags with:
	// name/content
	// property/content
	// name/value
	//
	// This will attempt to handle any combo of those
	
	for (TFHppleElement *element in metaTags) {
		NSString *metaName = (element.attributes[@"name"]) ?: element.attributes[@"property"];

		if (metaName && [metaName hasPrefix:@"twitter:"]) {
			NSString *name = [metaName substringFromIndex:8];
			NSString *content = (element.attributes[@"content"]) ?: element.attributes[@"value"];
			
			if (content) {
				dict[name] = content;
			}
		}
	}
	
	return dict;
}

+ (PLKItem *)parseItemFromDictionary:(NSDictionary *)dict
{
	return [PLKItem itemWithDictionary:@{
					@"url": [NSURL URLWithString:[dict plk_stringForKey:@"image"]],
					@"service": [dict plk_stringForKey:@"site"],
					@"type": [dict plk_stringForKey:@"card"]
					}];
}

@end
