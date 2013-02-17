//
//  PLKCloudAppServiceTest.h
//  PluckDemo
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface PLKCloudAppServiceTest : SenTestCase

- (void)testIsSupportedURL;
- (void)testItemFromDictionary;

#if TEST_LIVE
- (void)testLiveItemForURL;
#endif

@end
