//
//  PLKRdioServiceTest.m
//  PluckDemo
//
//  Created by Zach Waugh on 4/6/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKRdioServiceTest.h"
#import "PLKRdioService.h"
#import "PLKItem.h"

@implementation PLKRdioServiceTest

- (void)testIsSupportedURL
{
	expect([PLKRdioService isSupportedURL:[NSURL URLWithString:@"http://rd.io/x/QBStPlUnZA/"]]).to.beTruthy();
	expect([PLKRdioService isSupportedURL:[NSURL URLWithString:@"http://www.rdio.com/artist/College/"]]).to.beTruthy();
	
  expect([PLKRdioService isSupportedURL:[NSURL URLWithString:@"http://instagram.com/p/foo"]]).to.beFalsy();
	expect([PLKRdioService isSupportedURL:[NSURL URLWithString:@"http://example.com/foo"]]).to.beFalsy();
	expect([PLKRdioService isSupportedURL:[NSURL URLWithString:@"http://google.com"]]).to.beFalsy();
	expect([PLKRdioService isSupportedURL:[NSURL URLWithString:@"http://google.com/youtube"]]).to.beFalsy();
}

- (void)testItemFromDictionary
{
	NSString *jsonPath = [[NSBundle bundleForClass:self.class] pathForResource:@"rdio" ofType:@"json"];
	NSData *json = [NSData dataWithContentsOfFile:jsonPath];
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
	
	expect(json).toNot.beNil();
	expect(json.length).toNot.equal(0);
	expect(dict).toNot.beNil();
		
	PLKItem *item = [PLKRdioService itemFromDictionary:dict];
	expect(item).toNot.beNil();
	expect(item.type).to.equal(@"photo");
	expect(item.service).to.equal(@"Rdio");
	expect(item.title).to.equal(@"Superunknown");
  expect(item.url).to.equal([NSURL URLWithString:@"http://www.rdio.com/_is/?m=album/3/7/c/0000000000036c73/square-200.jpg&w=200&h=200"]);
	
  item = [PLKRdioService itemFromDictionary:@{}];
  expect(item).to.beNil();
}

@end
