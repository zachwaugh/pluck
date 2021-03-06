//
//  PLKDribbbleService.h
//  PluckDemo
//
//  Created by Zach Waugh on 2/18/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface PLKDribbbleServiceTest : SenTestCase

- (void)testIsSupportedURL;
- (void)testItemFromDictionary;

#if TEST_LIVE
- (void)testLiveItemForURL;
#endif

@end
