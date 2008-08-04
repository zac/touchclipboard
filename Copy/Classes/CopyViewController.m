//
//  CopyAppDelegate.m
//  Copy
//
//  Created by Zac White on 8/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "CopyViewController.h"

#import "ZWClipboard.h"

@implementation CopyViewController

- (IBAction)copy:(id)sender {	
	NSError *error = NULL;
	
	[[ZWClipboard sharedClipboard] copyData:[[textView text] dataUsingEncoding:NSUTF8StringEncoding] withMimeType:@"text/plain" error:&error];
	[[ZWClipboard sharedClipboard] writeToFile:NULL];
	if(error) NSLog(@"ERROR: %@", [error localizedDescription]);
}

- (IBAction)copyImage:(id)sender {
	NSError *error = NULL;
	
	[[ZWClipboard sharedClipboard] copyData:UIImagePNGRepresentation(imageView.image) withMimeType:@"image/png" error:&error];
	[[ZWClipboard sharedClipboard] writeToFile:NULL];
	
	if(error) NSLog(@"ERROR: %@", [error localizedDescription]);
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 Implement viewDidLoad if you need to do additional setup after loading the view.
- (void)viewDidLoad {
	[super viewDidLoad];
}
 */


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[super dealloc];
}

@end
