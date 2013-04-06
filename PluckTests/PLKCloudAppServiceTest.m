//
//  PLKCloudAppServiceTest.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKCloudAppServiceTest.h"
#import "PLKCloudAppService.h"
#import "PLKItem.h"

@implementation PLKCloudAppServiceTest

- (void)testIsSupportedURL
{
	expect([PLKCloudAppService isSupportedURL:[NSURL URLWithString:@"http://cl.ly/AJbz"]]).to.beTruthy();
	expect([PLKCloudAppService isSupportedURL:[NSURL URLWithString:@"http://cl.ly/image/0w2V3j0s010X"]]).to.beTruthy();
	
	expect([PLKCloudAppService isSupportedURL:[NSURL URLWithString:@"http://zdw.me/232343"]]).to.beFalsy();
	expect([PLKCloudAppService isSupportedURL:[NSURL URLWithString:@"http://vapor.ly/image/0w2V3j0s010X"]]).to.beFalsy();
}

- (void)testItemFromDictionary
{
	NSString *jsonPath = [[NSBundle bundleForClass:self.class] pathForResource:@"cloudapp" ofType:@"json"];
	NSData *json = [NSData dataWithContentsOfFile:jsonPath];
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
	
	expect(json).toNot.beNil();
	expect(json.length).toNot.equal(0);
	expect(dict).toNot.beNil();

	NSURL *contentURL = [NSURL URLWithString:dict[@"content_url"]];
	
	PLKItem *item = [PLKCloudAppService itemFromDictionary:dict];
	expect(item).toNot.beNil();	
	expect(item.type).to.equal(@"photo");
	expect(item.service).to.equal(@"CloudApp");
	expect(item.title).to.equal(@"Screen Shot 2013-02-15 at 3.41.57 PM.png");
	expect(item.url).to.equal(contentURL);
  
  item = [PLKCloudAppService itemFromDictionary:@{}];
  expect(item).to.beNil();
}

#if TEST_LIVE

- (void)testLiveItemForURL
{
	NSURL *url = [NSURL URLWithString:@"http://cl.ly/image/133D1l1l323P"];
	
	__block PLKItem *item = nil;
	__block NSError *error = nil;
	
	//[Expecta setAsynchronousTestTimeout:5];
	
	[PLKCloudAppService itemForURL:url completion:^(PLKItem *aItem, NSError *aError) {
		item = aItem;
		error = aError;
	}];
	
	NSURL *expectedURL = [NSURL URLWithString:@"http://cl.ly/image/133D1l1l323P/Screen%20Shot%202013-02-15%20at%203.41.57%20PM.png"];
	
	expect(item).willNot.beNil();
	expect(item.type).will.equal(@"image");
	expect(item.url).will.equal(expectedURL);
	expect(error).will.beNil();
}

#endif

@end
