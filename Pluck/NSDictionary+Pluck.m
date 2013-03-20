//
//  NSDictionary+Pluck.m
//  PluckDemo
//
//  Created by Zach Waugh on 3/20/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "NSDictionary+Pluck.h"

@implementation NSDictionary (Pluck)

- (NSString *)plk_stringForKey:(id)key;
{
  id value = [self objectForKey:key];
  return ([value isKindOfClass:[NSString class]]) ? value : @"";
}

@end
