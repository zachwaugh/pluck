//
//  PLKItem.m
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKItem.h"

@implementation PLKItem

+ (PLKItem *)itemWithDictionary:(NSDictionary *)dict
{
	return [[PLKItem alloc] initWithDictionary:dict];
}

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	if (!self) return nil;
	
	_url = dict[@"url"];
	_title = dict[@"title"];
	_service = dict[@"service"];
	_thumbnailURL = dict[@"thumbnail"];
	_type = dict[@"type"];
	
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"title: %@, url: %@, thumbnail: %@, type: %@", self.title, self.url, self.thumbnailURL, self.type];
}

@end
