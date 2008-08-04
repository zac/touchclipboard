//
//  PasteAppDelegate.m
//  Paste
//
//  Created by Zac White on 8/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "PasteAppDelegate.h"
#import "PasteViewController.h"

#import "ZWClipboard.h"

@implementation PasteAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
	// Override point for customization after app launch	
    [window addSubview:viewController.view];
	[window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
	[window release];
	[super dealloc];
}


@end
