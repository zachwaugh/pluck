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

- (BOOL)plk_isSafeForKeys:(NSArray *)keys
{
  for (NSString *key in keys) {
    id value = self[key];
    if (value == nil || value == [NSNull null]) {
      return NO;
    }
  }
  
  return YES;
}

@end
