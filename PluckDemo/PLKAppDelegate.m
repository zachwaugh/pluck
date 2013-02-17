//
//  PLKAppDelegate.m
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKAppDelegate.h"
#import "PLKService.h"
#import "PLKItem.h"

@implementation PLKAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}

- (IBAction)fetchURL:(id)sender
{
	NSURL *url = [NSURL URLWithString:self.url.stringValue];
	
	if (url && [PLKService isSupportedURL:url]) {
		[PLKService itemForURL:url block:^(PLKItem *item, NSError *error) {
			if (item) {
				self.imageView.image = [[NSImage alloc] initWithContentsOfURL:item.url];
				self.textView.string = item.description;
			} else {
				self.textView.string = error.localizedDescription;
			}
		}];
	} else {
		NSLog(@"unsupported url: %@", url);
	}
}

@end
