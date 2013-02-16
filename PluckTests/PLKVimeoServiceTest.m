//
//  PLKVimeoServiceTest.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKVimeoServiceTest.h"
#import "PLKVimeoService.h"
#import "PLKItem.h"

@implementation PLKVimeoServiceTest

- (void)testIsPluckableURL
{
	expect([PLKVimeoService isPluckableURL:[NSURL URLWithString:@"http://vimeo.com/7100569"]]).to.beTruthy();
	
	expect([PLKVimeoService isPluckableURL:[NSURL URLWithString:@"http://example.com/foo"]]).to.beFalsy();
	expect([PLKVimeoService isPluckableURL:[NSURL URLWithString:@"http://google.com"]]).to.beFalsy();
	expect([PLKVimeoService isPluckableURL:[NSURL URLWithString:@"http://google.com/youtube"]]).to.beFalsy();
}

- (void)testItemFromDictionary
{
	NSString *jsonPath = [[NSBundle bundleForClass:self.class] pathForResource:@"vimeo" ofType:@"json"];
	NSData *json = [NSData dataWithContentsOfFile:jsonPath];
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
	
	expect(json).toNot.beNil();
	expect(json.length).toNot.equal(0);
	expect(dict).toNot.beNil();
	
	PLKItem *item = [PLKVimeoService itemFromDictionary:dict];
	expect(item).toNot.beNil();
	expect(item.type).to.equal(@"video");
	expect(item.url).to.equal([NSURL URLWithString:@"http://b.vimeocdn.com/ts/294/128/29412830_1280.jpg"]);
	expect(item.service).to.equal(@"Vimeo");
	expect(item.title).to.equal(@"Brad!");
}

#if TEST_LIVE
- (void)testLiveItemForURL
{
	
}
#endif

@end
