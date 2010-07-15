
/*
     File: ViewController.m
 Abstract: View controller that adds a keyboard accessory to a text view.
 
  Version: 1.2
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import "ViewController.h"
#import "Window.h"

@implementation ViewController

@synthesize gestureView, mimicView;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Observe keyboard hide and show notifications to resize the text view appropriately.
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
}


- (void)viewDidUnload {
    [super viewDidUnload];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    
    // Make the keyboard appear when the application launches.
    //[super viewWillAppear:animated];
    //[textView becomeFirstResponder];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark -
#pragma mark Text view delegate methods
/*
- (BOOL)textViewShouldBeginEditing:(UITextView *)aTextView {
    [[NSBundle mainBundle] loadNibNamed:@"GestureView" owner:self options:nil];
    //[[NSBundle mainBundle] loadNibNamed:@"MimicView" owner:self options:nil];
	// Loading the AccessoryView nib file sets the accessoryView outlet. 
	//NSLog(@"%@",gestureView);
	//[textView addSubview:gestureView];
	Window *newKeyboardWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 215)];
	//UIViewController* newViewController = [[UIViewController alloc] initWithNibName:@"GestureView" bundle:[NSBundle mainBundle]];
	//[newKeyboardWindow addSubview:newViewController.view];
	//[newKeyboardWindow addSubview:mimicView];
	[newKeyboardWindow addSubview:gestureView];
	[newKeyboardWindow makeKeyAndVisible];	
	//[mimicView addSubview:gestureView];
	textView.inputView = newKeyboardWindow;
	NSLog(@"superview:%@,input super view:%@, keywindow:%d",textView.superview,textView.inputView,newKeyboardWindow.keyWindow);
	
    
     //You can create the accessory view programmatically (in code), in the same nib file as the view controller's main view, or from a separate nib file. This example illustrates the latter; it means the accessory view is loaded lazily -- only if it is required.
     
	//NSLog(@"modify");
	//UIWindow* newKeyboardWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 215)];
	//[newKeyboardWindow addSubview:accessoryView];	
    
    if (textView.inputAccessoryView == nil) {
		NSLog(@"accessory view = nil");
        
		// After setting the accessory view for the text view, we no longer need a reference to the accessory view.
        self.accessoryView = nil;
    }
	
    return YES;
}


- (BOOL)textViewShouldEndEditing:(UITextView *)aTextView {
    [aTextView resignFirstResponder];
    return YES;
}


#pragma mark -
#pragma mark Responding to keyboard events

- (void)keyboardWillShow:(NSNotification *)notification {
    
    
     //Reduce the size of the text view so that it's not obscured by the keyboard.
     //Animate the resize so that it's in sync with the appearance of the keyboard.
     
	

    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];

    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    textView.frame = newTextViewFrame;
    [UIView commitAnimations];  
	/*for (UIView *sub in [[super view] subviews]) {
		NSLog(@"%@",sub);
	}*/
	
	
	//find out the keyboard view and add
	/*
	for (UIWindow *keyboardWindow in [[UIApplication sharedApplication] windows]) {
		for (UIView *keyboard in [keyboardWindow subviews]) {
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES) {
				NSLog(@"%@",keyboardWindow);

				//[[NSBundle mainBundle] loadNibNamed:@"GestureView" owner:self options:nil];
				//[keyboard addSubview:accessoryView];			
			}
		}
	}
	
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    textView.frame = self.view.bounds;
    
    [UIView commitAnimations]; 
}


#pragma mark -
#pragma mark Accessory view action

- (IBAction)tappedMe:(id)sender {
    
    // When the accessory view button is tapped, add a suitable string to the text view.
    NSMutableString *text = [textView.text mutableCopy];
    NSRange selectedRange = textView.selectedRange;
    
    [text replaceCharactersInRange:selectedRange withString:@"You tapped me.\n"];
    textView.text = text;
    [text release];
}
- (IBAction)q:(id)sender {
    
    // When the accessory view button is tapped, add a suitable string to the text view.
    NSMutableString *text = [textView.text mutableCopy];
    NSRange selectedRange = textView.selectedRange;
    
    [text replaceCharactersInRange:selectedRange withString:@"q"];
    textView.text = text;
    [text release];
}
- (IBAction)m:(id)sender {
    
    // When the accessory view button is tapped, add a suitable string to the text view.
    NSMutableString *text = [textView.text mutableCopy];
    NSRange selectedRange = textView.selectedRange;
    
    [text replaceCharactersInRange:selectedRange withString:@"m"];
    textView.text = text;
    [text release];
}
- (IBAction)s:(id)sender {
    
    // When the accessory view button is tapped, add a suitable string to the text view.
    NSMutableString *text = [textView.text mutableCopy];
    NSRange selectedRange = textView.selectedRange;
    
    [text replaceCharactersInRange:selectedRange withString:@"s"];
    textView.text = text;
    [text release];
}
- (IBAction)a:(id)sender {
    
    // When the accessory view button is tapped, add a suitable string to the text view.
    NSMutableString *text = [textView.text mutableCopy];
    NSRange selectedRange = textView.selectedRange;
    
    [text replaceCharactersInRange:selectedRange withString:@"a"];
    textView.text = text;
    [text release];
}
- (IBAction)y:(id)sender {
    
    // When the accessory view button is tapped, add a suitable string to the text view.
    NSMutableString *text = [textView.text mutableCopy];
    NSRange selectedRange = textView.selectedRange;
    
    [text replaceCharactersInRange:selectedRange withString:@"y"];
    textView.text = text;
    [text release];
}

*/
#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
    //[textView release];
    [super dealloc];
}

@end
