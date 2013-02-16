//
//  PLKItem.h
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLKItem : NSObject

@property (strong, readonly) NSURL *url;
@property (strong, readonly) NSString *title;
@property (strong, readonly) NSURL *thumbnailURL;
@property (strong, readonly) NSString *type;
@property (strong, readonly) NSString *service;

+ (PLKItem *)itemWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;

@end
