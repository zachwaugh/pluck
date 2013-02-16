//
//  NSURL+Pluck.h
//  PluckDemo
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Pluck)

- (BOOL)plk_isMatchedByRegex:(NSString *)regex;

@end
