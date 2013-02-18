//
//  PLKAppDelegate.h
//  Pluck
//
//  Created by Zach Waugh on 2/16/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PLKAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *url;
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (weak) IBOutlet NSImageView *imageView;
@property (assign) BOOL loading;

- (IBAction)fetchURL:(id)sender;

@end
