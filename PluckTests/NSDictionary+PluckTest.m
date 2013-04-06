//
//  NSDictionary+PluckTest.m
//  PluckDemo
//
//  Created by Zach Waugh on 4/6/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "NSDictionary+PluckTest.h"
#import "NSDictionary+Pluck.h"

@implementation NSDictionary_PluckTest

- (void)testStringForKey
{
	NSDictionary *dict = @{ @"key": @"ok", @"nullKey": [NSNull null] };
	expect(dict[@"key"]).to.equal(@"ok");
	expect([dict plk_stringForKey:@"key"]).to.equal(@"ok");
	expect(dict[@"nullKey"]).to.equal([NSNull null]);
	expect([dict plk_stringForKey:@"nullKey"]).to.equal(@"");
	expect([dict plk_stringForKey:@"nilKey"]).to.equal(@"");
}

- (void)testHasValuesForKeys
{
	NSDictionary *dict = @{ @"key1": @"value1", @"key2": @"value2", @"nullKey": [NSNull null] };
	NSArray *keys = @[@"key1", @"key2"];
	expect([dict plk_hasValuesForKeys:keys]).to.beTruthy();
	
	keys = @[];
	expect([dict plk_hasValuesForKeys:keys]).to.beTruthy();
	
	keys = @[@"key1"];
	expect([dict plk_hasValuesForKeys:keys]).to.beTruthy();
	
	keys = @[@"key2"];
	expect([dict plk_hasValuesForKeys:keys]).to.beTruthy();
	
	keys = @[@"key1", @"key2", @"key3"];
	expect([dict plk_hasValuesForKeys:keys]).to.beFalsy();
	
	keys = @[@"key1", @"key2", @"nullKey"];
	expect([dict plk_hasValuesForKeys:keys]).to.beFalsy();
	
	keys = @[@"key3", @"key4"];
	expect([dict plk_hasValuesForKeys:keys]).to.beFalsy();
}

@end
