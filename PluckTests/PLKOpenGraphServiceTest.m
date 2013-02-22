//
//  PLKOpenGraphServiceTest.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/21/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKOpenGraphServiceTest.h"
#import "PLKOpenGraphService.h"
#import "PLKItem.h"

@implementation PLKOpenGraphServiceTest

// Support varies, so test a few different services and their implementation
// All data loaded by saving html from curl, so could possibly be outdated
- (void)testOpenGraphTagsFromHTML
{
	// CloudApp link
	NSData *htmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"cloud" ofType:@"html"]];
	NSDictionary *dict = [PLKOpenGraphService openGraphAttributesFromHTMLData:htmlData];
	
	expect(dict).toNot.beNil();
	expect(dict[@"title"]).to.equal(@"Image 2013-02-14 at 3.20.51 PM.png");
	expect(dict[@"site_name"]).to.equal(@"CloudApp");
	expect(dict[@"url"]).to.equal(@"http://cl.ly/image/2z2N0O2V3D0y");
	expect(dict[@"image"]).to.equal(@"http://thumbs.getcloudapp.com/2z2N0O2V3D0y");
	
	// IMDb link
	htmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"imdb" ofType:@"html"]];
	dict = [PLKOpenGraphService openGraphAttributesFromHTMLData:htmlData];
	
	expect(dict).toNot.beNil();
	expect(dict[@"title"]).to.equal(@"Argo (2012)");
	expect(dict[@"site_name"]).to.equal(@"IMDb");
	expect(dict[@"url"]).to.equal(@"http://www.imdb.com/title/tt1024648/");
	expect(dict[@"image"]).to.equal(@"http://ia.media-imdb.com/images/M/MV5BMTc3MjI0MjM0NF5BMl5BanBnXkFtZTcwMTYxMTQ1OA@@._V1_SY317_CR0,0,214,317_.jpg");
	
	// Github
	htmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"github" ofType:@"html"]];
	dict = [PLKOpenGraphService openGraphAttributesFromHTMLData:htmlData];
	
	expect(dict).toNot.beNil();
	expect(dict[@"title"]).to.equal(@"pluck");
	expect(dict[@"site_name"]).to.equal(@"GitHub");
	expect(dict[@"url"]).to.equal(@"https://github.com/zachwaugh/pluck");
	expect(dict[@"image"]).to.equal(@"https://secure.gravatar.com/avatar/8f0b58e74434edaf2917c9d3d657188e?s=420&d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png");
}

- (void)testItemFromDictionary
{
	// CloudApp
	NSData *htmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"cloud" ofType:@"html"]];
	NSDictionary *dict = [PLKOpenGraphService openGraphAttributesFromHTMLData:htmlData];
	
	expect(htmlData).toNot.beNil();
	expect(dict).toNot.beNil();
		
	PLKItem *item = [PLKOpenGraphService itemFromDictionary:dict];
	expect(item).toNot.beNil();
	expect(item.type).to.equal(@"photo");
	expect(item.service).to.equal(@"CloudApp");
	expect(item.title).to.equal(@"Image 2013-02-14 at 3.20.51 PM.png");
	expect(item.url).to.equal([NSURL URLWithString:@"http://thumbs.getcloudapp.com/2z2N0O2V3D0y"]);
	
	// IMDb
	htmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"imdb" ofType:@"html"]];
	dict = [PLKOpenGraphService openGraphAttributesFromHTMLData:htmlData];
	
	expect(htmlData).toNot.beNil();
	expect(dict).toNot.beNil();
	
	item = [PLKOpenGraphService itemFromDictionary:dict];
	expect(item).toNot.beNil();
	expect(item.type).to.equal(@"photo");
	expect(item.service).to.equal(@"IMDb");
	expect(item.title).to.equal(@"Argo (2012)");
	expect(item.url).to.equal([NSURL URLWithString:@"http://ia.media-imdb.com/images/M/MV5BMTc3MjI0MjM0NF5BMl5BanBnXkFtZTcwMTYxMTQ1OA@@._V1_SY317_CR0,0,214,317_.jpg"]);
	
	// GitHub
	htmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"github" ofType:@"html"]];
	dict = [PLKOpenGraphService openGraphAttributesFromHTMLData:htmlData];
	
	expect(htmlData).toNot.beNil();
	expect(dict).toNot.beNil();
	
	item = [PLKOpenGraphService itemFromDictionary:dict];
	expect(item).toNot.beNil();
	expect(item.type).to.equal(@"photo");
	expect(item.service).to.equal(@"GitHub");
	expect(item.title).to.equal(@"pluck");
	expect(item.url).to.equal([NSURL URLWithString:@"https://secure.gravatar.com/avatar/8f0b58e74434edaf2917c9d3d657188e?s=420&d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"]);
}

@end
