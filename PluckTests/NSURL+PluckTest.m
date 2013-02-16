//
//  NSURL+PluckTest.m
//  PluckDemo
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "NSURL+PluckTest.h"
#import "NSURL+Pluck.h"

@implementation NSURL_PluckTest

- (void)testIsMatchedByRegex
{
	expect([[NSURL URLWithString:@"http://google.com"] plk_isMatchedByRegex:@"http://google.com"]).to.beTruthy();
	expect([[NSURL URLWithString:@"http://google.com"] plk_isMatchedByRegex:@"https?://*google.*"]).to.beTruthy();
	expect([[NSURL URLWithString:@"http://www.google.com/search"] plk_isMatchedByRegex:@".*google.*"]).to.beTruthy();
	expect([[NSURL URLWithString:@"http://www.google.com/search"] plk_isMatchedByRegex:@".*apple.*"]).to.beFalsy();
	expect([[NSURL URLWithString:@"http://apple.com/iphone"] plk_isMatchedByRegex:@".*apple.*"]).to.beTruthy();
}

@end
