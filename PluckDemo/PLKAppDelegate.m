//
//  PLKAppDelegate.m
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKAppDelegate.h"
#import "Pluck.h"

@implementation PLKAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (IBAction)fetchURL:(id)sender
{
	NSURL *url = [NSURL URLWithString:self.url.stringValue];
	
	if (url && [PLKService isSupportedURL:url]) {
    self.loading = YES;
		[PLKService itemForURL:url completion:^(PLKItem *item, NSError *error) {
			if (item) {
				self.imageView.image = [[NSImage alloc] initWithContentsOfURL:item.url];
				self.textView.string = [[item.description componentsSeparatedByString:@", "] componentsJoinedByString:@"\n"];
			} else {
				self.textView.string = (error) ? error.localizedDescription : @"Unknown error";
			}
      
      self.loading = NO;
		}];
	} else {
		self.loading = YES;
		[PLKOpenGraphService itemForURL:url completion:^(PLKItem *item, NSError *error) {
			if (item) {
				self.imageView.image = [[NSImage alloc] initWithContentsOfURL:item.url];
				self.textView.string = [[item.description componentsSeparatedByString:@", "] componentsJoinedByString:@"\n"];
			} else {
				self.textView.string = [NSString stringWithFormat:@"Unsupported url: %@", url];
			}
      
      self.loading = NO;
		}];
	}
}

@end
