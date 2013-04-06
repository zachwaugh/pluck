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

- (void)testIsSupportedURL
{
	expect([PLKService isSupportedURL:nil]).to.beFalsy();
	expect([PLKService isSupportedURL:[NSURL URLWithString:@"http://cl.ly/AJbz"]]).to.beTruthy();
	expect([PLKService isSupportedURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=90Omh7_I8vI"]]).to.beTruthy();
	expect([PLKService isSupportedURL:[NSURL URLWithString:@"http://flic.kr/p/8yKma5"]]).to.beTruthy();
	expect([PLKService isSupportedURL:[NSURL URLWithString:@"http://vimeo.com/7100569"]]).to.beTruthy();
	expect([PLKService isSupportedURL:[NSURL URLWithString:@"http://instagram.com/p/U6OD6Dq5LB/"]]).to.beTruthy();
  expect([PLKService isSupportedURL:[NSURL URLWithString:@"http://dribbble.com/shots/931225-New-emoji-autocomplete-in-Flint"]]).to.beTruthy();
	expect([PLKService isSupportedURL:[NSURL URLWithString:@"http://d.pr/i/xQxb"]]).to.beTruthy();
	expect([PLKService isSupportedURL:[NSURL URLWithString:@"http://rd.io/x/QBStPlUnZA/"]]).to.beTruthy();
}

- (void)testItemForURL
{
	NSURL *url = nil;
	
	__block PLKItem *item = nil;
	__block NSError *error = nil;
	
	[PLKService itemForURL:url completion:^(PLKItem *aItem, NSError *aError) {
		item = aItem;
		error = aError;
	}];
	
	expect(item).to.beNil();
	expect(error).toNot.beNil();
	expect(error.domain).to.equal(PLKErrorDomain);
	expect(error.code).to.equal(PLKErrorUnsupportedURL);
}

@end
