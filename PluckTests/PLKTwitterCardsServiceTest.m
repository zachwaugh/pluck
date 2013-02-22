//
//  PLKTwitterCardsServiceTest.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/21/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKTwitterCardsServiceTest.h"
#import "PLKTwitterCardsService.h"
#import "PLKItem.h"

@implementation PLKTwitterCardsServiceTest

- (void)testTwitterCardsTagsFromHTML
{
	// CloudApp link
	NSData *htmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"cloud" ofType:@"html"]];
	NSDictionary *dict = [PLKTwitterCardsService twitterCardsAttributesFromHTMLData:htmlData];
		
	expect(htmlData).toNot.beNil();
	expect(dict).toNot.beNil();
	expect(dict[@"image"]).to.equal(@"http://f.cl.ly/items/0A0U011D3G3K3h361E00/Image%202013-02-14%20at%203.20.51%20PM.png");
	expect(dict[@"site"]).to.equal(@"@cloudapp");
	expect(dict[@"card"]).to.equal(@"photo");
	
	// GitHub
	htmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"github" ofType:@"html"]];
	dict = [PLKTwitterCardsService twitterCardsAttributesFromHTMLData:htmlData];
	
	expect(htmlData).toNot.beNil();
	expect(dict).toNot.beNil();
	expect(dict[@"image"]).to.beNil();
	expect(dict[@"site"]).to.equal(@"@GitHub");
	expect(dict[@"card"]).to.equal(@"summary");
}

- (void)testItemFromDictionary
{
	NSString *htmlPath = [[NSBundle bundleForClass:self.class] pathForResource:@"cloud" ofType:@"html"];
	NSData *htmlData = [NSData dataWithContentsOfFile:htmlPath];
	NSDictionary *dict = [PLKTwitterCardsService twitterCardsAttributesFromHTMLData:htmlData];
	
	expect(htmlData).toNot.beNil();
	expect(dict).toNot.beNil();
	
	PLKItem *item = [PLKTwitterCardsService itemFromDictionary:dict];
	expect(item).toNot.beNil();
	expect(item.type).to.equal(@"photo");
	expect(item.service).to.equal(@"@cloudapp");
	expect(item.url).to.equal([NSURL URLWithString:@"http://f.cl.ly/items/0A0U011D3G3K3h361E00/Image%202013-02-14%20at%203.20.51%20PM.png"]);
}

@end
