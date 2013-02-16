//
//  PLKServiceTest.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKServiceTest.h"
#import "PLKService.h"

@implementation PLKServiceTest

- (void)testIsPluckable
{
	expect([PLKService isPluckableURL:nil]).to.beFalsy();
	expect([PLKService isPluckableURL:[NSURL URLWithString:@"http://cl.ly/AJbz"]]).to.beTruthy();
	expect([PLKService isPluckableURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=90Omh7_I8vI"]]).to.beTruthy();
	expect([PLKService isPluckableURL:[NSURL URLWithString:@"http://flic.kr/p/8yKma5"]]).to.beTruthy();
}

- (void)testItemForURL
{
	NSURL *url = nil;
	
	__block PLKItem *item = nil;
	__block NSError *error = nil;
	
	[PLKService itemForURL:url block:^(PLKItem *aItem, NSError *aError) {
		item = aItem;
		error = aError;
	}];
	
	expect(item).to.beNil();
	expect(error).toNot.beNil();
	expect(error.domain).to.equal(PLKErrorDomain);
	expect(error.code).to.equal(PLKErrorUnsupportedURL);
}

@end
