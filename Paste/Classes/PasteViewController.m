//
//  PasteAppDelegate.m
//  Paste
//
//  Created by Zac White on 8/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "PasteViewController.h"

@implementation PasteViewController

- (IBAction)paste:(id)sender {
	ZWClipboardItem *item = [[ZWClipboard sharedClipboard] pasteLatestWithMimeType:@"text/plain" error:NULL];
	NSLog(@"item: %@", item);
	textView.text = [[[NSString alloc] initWithData:item.data encoding:NSUTF8StringEncoding] autorelease];
}

- (IBAction)pasteImage:(id)sender {
	ZWClipboardItem *item = [[ZWClipboard sharedClipboard] pasteLatestWithMimeType:@"image/png" error:NULL];
	imageView.image = [UIImage imageWithData:item.data];
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
