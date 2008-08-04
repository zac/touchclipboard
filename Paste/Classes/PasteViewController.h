//
//  PasteViewController.h
//  Paste
//
//  Created by Zac White on 8/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZWClipboard.h"

@interface PasteViewController : UIViewController {
	IBOutlet UITextView *textView;
	
	IBOutlet UIImageView *imageView;
}

- (IBAction)paste:(id)sender;
- (IBAction)pasteImage:(id)sender;

@end

