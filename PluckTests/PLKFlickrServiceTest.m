//
//  PLKFlickrServiceTest.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKFlickrServiceTest.h"
#import "PLKFlickrService.h"
#import "PLKItem.h"

@implementation PLKFlickrServiceTest

- (void)testIsSupportedURL
{
	expect([PLKFlickrService isSupportedURL:[NSURL URLWithString:@"http://www.flickr.com/photos/zwaugh/4965082870/in/photostream"]]).to.beTruthy();
	expect([PLKFlickrService isSupportedURL:[NSURL URLWithString:@"http://flic.kr/p/8yKma5"]]).to.beTruthy();
	
	expect([PLKFlickrService isSupportedURL:[NSURL URLWithString:@"http://example.com/foo"]]).to.beFalsy();
	expect([PLKFlickrService isSupportedURL:[NSURL URLWithString:@"http://google.com"]]).to.beFalsy();
	expect([PLKFlickrService isSupportedURL:[NSURL URLWithString:@"http://google.com/youtube"]]).to.beFalsy();
}

- (void)testItemFromDictionary
{
	NSString *jsonPath = [[NSBundle bundleForClass:self.class] pathForResource:@"flickr" ofType:@"json"];
	NSData *json = [NSData dataWithContentsOfFile:jsonPath];
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
	
	expect(json).toNot.beNil();
	expect(json.length).toNot.equal(0);
	expect(dict).toNot.beNil();
	
	PLKItem *item = [PLKFlickrService itemFromDictionary:dict];
	expect(item).toNot.beNil();
	expect(item.type).to.equal(@"photo");
	expect(item.url).to.equal([NSURL URLWithString:@"http://farm5.staticflickr.com/4109/4965082870_00725ef91e_b.jpg"]);
	expect(item.service).to.equal(@"Flickr");
	expect(item.title).to.equal(@"Zoe with feather");
}

#if TEST_LIVE
- (void)testLiveItemForURL
{
	
}
#endif

@end
