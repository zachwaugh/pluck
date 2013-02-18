//
//  PLKDribbbleService.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/18/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKDribbbleServiceTest.h"
#import "PLKDribbbleService.h"
#import "PLKItem.h"

@interface PLKDribbbleService (private)

+ (NSURL *)apiURLForURL:(NSURL *)url;

@end

@implementation PLKDribbbleServiceTest

- (void)testIsSupportedURL
{
	expect([PLKDribbbleService isSupportedURL:[NSURL URLWithString:@"http://dribbble.com/shots/931225-New-emoji-autocomplete-in-Flint"]]).to.beTruthy();
	expect([PLKDribbbleService isSupportedURL:[NSURL URLWithString:@"http://drbl.in/gGuj"]]).to.beFalsy(); // short urls not supported yet
	
  expect([PLKDribbbleService isSupportedURL:[NSURL URLWithString:@"http://instagram.com/p/foo"]]).to.beFalsy();
	expect([PLKDribbbleService isSupportedURL:[NSURL URLWithString:@"http://example.com/foo"]]).to.beFalsy();
	expect([PLKDribbbleService isSupportedURL:[NSURL URLWithString:@"http://google.com"]]).to.beFalsy();
	expect([PLKDribbbleService isSupportedURL:[NSURL URLWithString:@"http://google.com/youtube"]]).to.beFalsy();
}

- (void)testItemFromDictionary
{
	NSString *jsonPath = [[NSBundle bundleForClass:self.class] pathForResource:@"dribbble" ofType:@"json"];
	NSData *json = [NSData dataWithContentsOfFile:jsonPath];
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
	
	expect(json).toNot.beNil();
	expect(json.length).toNot.equal(0);
	expect(dict).toNot.beNil();
	
	PLKItem *item = [PLKDribbbleService itemFromDictionary:dict];
	expect(item).toNot.beNil();
	expect(item.type).to.equal(@"photo");
	expect(item.url).to.equal([NSURL URLWithString:@"http://dribbble.s3.amazonaws.com/users/1963/screenshots/931225/flint-emoji-autocomplete.png"]);
	expect(item.service).to.equal(@"Dribbble");
	expect(item.title).to.equal(@"New emoji autocomplete in Flint");
}

- (void)testAPIURLforURL
{
  NSURL *url = [NSURL URLWithString:@"http://dribbble.com/shots/931225-New-emoji-autocomplete-in-Flint"];
  NSURL *apiURL = [PLKDribbbleService apiURLForURL:url];
  expect(apiURL).to.equal([NSURL URLWithString:@"http://api.dribbble.com/shots/931225-New-emoji-autocomplete-in-Flint"]);
  
  // Don't care about query string
  apiURL = [PLKDribbbleService apiURLForURL:[NSURL URLWithString:@"http://dribbble.com/shots/931225-New-emoji-autocomplete-in-Flint?list=following"]];
  expect(apiURL).to.equal([NSURL URLWithString:@"http://api.dribbble.com/shots/931225-New-emoji-autocomplete-in-Flint"]);
}

#if TEST_LIVE
- (void)testLiveItemForURL
{
	
}
#endif

@end
