//
//  PLKDroplrServiceTest.m
//  PluckDemo
//
//  Created by Zach Waugh on 3/20/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKDroplrServiceTest.h"
#import "PLKDroplrService.h"
#import "PLKItem.h"

@implementation PLKDroplrServiceTest

- (void)testIsSupportedURL
{
	expect([PLKDroplrService isSupportedURL:[NSURL URLWithString:@"http://d.pr/i/xQxb"]]).to.beTruthy();
	expect([PLKDroplrService isSupportedURL:[NSURL URLWithString:@"http://d.pr/i/u6mX"]]).to.beTruthy();
	
	expect([PLKDroplrService isSupportedURL:[NSURL URLWithString:@"http://zdw.me/232343"]]).to.beFalsy();
	expect([PLKDroplrService isSupportedURL:[NSURL URLWithString:@"http://droplr.com/help"]]).to.beFalsy();
}

- (void)testItemFromDictionary
{
  NSData *htmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"droplr" ofType:@"html"]];
	NSDictionary *dict = [PLKDroplrService openGraphAttributesFromHTMLData:htmlData];
  
  expect(htmlData).toNot.beNil();
  expect(dict).toNot.beNil();

	NSURL *image = [NSURL URLWithString:@"http://d.pr/i/xQxb/medium"];
	
	PLKItem *item = [PLKDroplrService itemFromDictionary:dict];
	expect(item).toNot.beNil();
	expect(item.type).to.equal(@"photo");
	expect(item.service).to.equal(@"Droplr");
	expect(item.title).to.equal(@"Screenshot on 2013-03-20 at 16.25.30.png");
	expect(item.url).to.equal(image);
}

@end
