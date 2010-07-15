//
//  Window.h
//  Multitouch_v1
//
//  Created by 鄭  龍磻 on 2010/5/10.
//  Copyright 2010  NTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLGestureRecognizer.h"
#import "GestureView.h"

@interface Window : UIWindow <GLGestureRecognizerDelegate,GestureViewDelegate>{
	GestureView* canvas;
	UITextView* textView;
	UIView* mimicKeyboard;
	UIButton* shift;
}


@property (nonatomic,retain) IBOutlet GestureView* canvas;
@property (nonatomic,retain) IBOutlet UITextView* textView;
@property (nonatomic,retain) IBOutlet UIView* mimicKeyboard;

@property (nonatomic,retain) IBOutlet UIButton* shift;

- (IBAction)pushKey:(id)sender;
- (IBAction)backspace:(id)sender;
-(IBAction)returnKey:(id)sender;
-(IBAction)spaceKey:(id)sender;
-(IBAction)shiftKey:(id)sender;
@end
