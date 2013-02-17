//
//  PLKYoutubeServiceTest.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKYoutubeServiceTest.h"
#import "PLKYoutubeService.h"
#import "PLKItem.h"

@implementation PLKYoutubeServiceTest

- (void)testIsSupportedURL
{
	expect([PLKYoutubeService isSupportedURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=90Omh7_I8vI"]]).to.beTruthy();
	expect([PLKYoutubeService isSupportedURL:[NSURL URLWithString:@"http://youtu.be/ckfBGdZoR_0"]]).to.beTruthy();
	
	expect([PLKYoutubeService isSupportedURL:[NSURL URLWithString:@"http://example.com/foo"]]).to.beFalsy();
	expect([PLKYoutubeService isSupportedURL:[NSURL URLWithString:@"http://google.com"]]).to.beFalsy();
	expect([PLKYoutubeService isSupportedURL:[NSURL URLWithString:@"http://google.com/youtube"]]).to.beFalsy();
}

- (void)testItemFromDictionary
{
	NSString *jsonPath = [[NSBundle bundleForClass:self.class] pathForResource:@"youtube" ofType:@"json"];
	NSData *json = [NSData dataWithContentsOfFile:jsonPath];
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
	
	expect(json).toNot.beNil();
	expect(json.length).toNot.equal(0);
	expect(dict).toNot.beNil();
		
	PLKItem *item = [PLKYoutubeService itemFromDictionary:dict];
	expect(item).toNot.beNil();
	expect(item.url).to.equal([NSURL URLWithString:@"http://i3.ytimg.com/vi/bDOYN-6gdRE/hqdefault.jpg"]);
	expect(item.service).to.equal(@"YouTube");
	expect(item.title).to.equal(@"Auto-Tune the News #8: dragons. geese. Michael Vick. (ft. T-Pain)");
}

#if TEST_LIVE
- (void)testLiveItemForURL
{

}
#endif

@end
