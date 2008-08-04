//
//  CopyViewController.h
//  Copy
//
//  Created by Zac White on 8/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CopyViewController : UIViewController {
	IBOutlet UITextView *textView;
	
	IBOutlet UIImageView *imageView;
}
- (IBAction)copy:(id)sender;
- (IBAction)copyImage:(id)sender;

@end

