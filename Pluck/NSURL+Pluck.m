//
//  NSURL+Pluck.m
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "NSURL+Pluck.h"

@implementation NSURL (Pluck)

- (BOOL)plk_isMatchedByRegex:(NSString *)expression
{
	NSString *url = self.absoluteString;
	
  NSError *error = nil;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
  
	if (error) {
		NSLog(@"error creating regex: %@", error);
	}
	
  NSRange wholeRange = NSMakeRange(0, url.length);
  NSArray *matches = [regex matchesInString:url options:0 range:wholeRange];
	
  return (matches.count == 1 && NSEqualRanges([(NSTextCheckingResult *)matches[0] range], wholeRange));
}

@end
