//
//  PLKInstagramServiceTest.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKInstagramServiceTest.h"
#import "PLKInstagramService.h"
#import "PLKItem.h"

@implementation PLKInstagramServiceTest

- (void)testIsSupportedURL
{
	expect([PLKInstagramService isSupportedURL:[NSURL URLWithString:@"http://instagr.am/p/U6OD6Dq5LB/"]]).to.beTruthy();
	expect([PLKInstagramService isSupportedURL:[NSURL URLWithString:@"http://instagram.com/p/TudRWdK5J2/"]]).to.beTruthy();
	
	expect([PLKInstagramService isSupportedURL:[NSURL URLWithString:@"http://example.com/foo"]]).to.beFalsy();
	expect([PLKInstagramService isSupportedURL:[NSURL URLWithString:@"http://google.com"]]).to.beFalsy();
	expect([PLKInstagramService isSupportedURL:[NSURL URLWithString:@"http://google.com/youtube"]]).to.beFalsy();
}

- (void)testItemFromDictionary
{
	NSString *jsonPath = [[NSBundle bundleForClass:self.class] pathForResource:@"instagram" ofType:@"json"];
	NSData *json = [NSData dataWithContentsOfFile:jsonPath];
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
	
	expect(json).toNot.beNil();
	expect(json.length).toNot.equal(0);
	expect(dict).toNot.beNil();
	
	PLKItem *item = [PLKInstagramService itemFromDictionary:dict];
	expect(item).toNot.beNil();
	expect(item.type).to.equal(@"photo");
	expect(item.url).to.equal([NSURL URLWithString:@"http://distilleryimage9.s3.amazonaws.com/6d17569066f911e2b1c722000a1fba7b_7.jpg"]);
	expect(item.service).to.equal(@"Instagram");
	expect(item.title).to.equal(@"Morning");
}

#if TEST_LIVE
- (void)testLiveItemForURL
{
	
}
#endif

@end
