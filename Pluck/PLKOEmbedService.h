//
//  PLKOEmbedService.h
//  PluckDemo
//
//  Created by Zach Waugh on 2/17/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKService.h"

@interface PLKOEmbedService : PLKService

+ (NSDictionary *)oEmbedParamsForURL:(NSURL *)url;
+ (NSURL *)oEmbedBaseURL;

@end
