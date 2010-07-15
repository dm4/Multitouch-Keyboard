//
//  Window.m
//  Multitouch_v1
//
//  Created by 鄭  龍磻 on 2010/5/10.
//  Copyright 2010  NTU. All rights reserved.
//

#import "Window.h"
#import "GestureView.h"

@implementation Window
@synthesize canvas;
@synthesize textView;
@synthesize mimicKeyboard;
@synthesize shift;

BOOL shifted= NO;
BOOL moving = NO;

- (void) sendEvent:(UIEvent *)event
{
	
    //for (TransformGesture *gesture in transformGestures) {
        // collect all the touches we care about from the event
		NSSet * touches = [event allTouches];
       // NSSet *touches = [gesture observedTouchesForEvent:event];
        NSMutableSet *began = nil;
        NSMutableSet *moved = nil;
        NSMutableSet *ended = nil;
        NSMutableSet *cancelled = nil;
		
        // sort the touches by phase so we can handle them similarly to normal event dispatch
        for(UITouch *touch in touches) {
            switch ([touch phase]) {
                case UITouchPhaseBegan:
                    if (!began) began = [NSMutableSet set];
                    [began addObject:touch];
                    break;
                case UITouchPhaseMoved:
                    if (!moved) moved = [NSMutableSet set];
                    [moved addObject:touch];
                    break;
                case UITouchPhaseEnded:
                    if (!ended) ended = [NSMutableSet set];
                    [ended addObject:touch];
                    break;
                case UITouchPhaseCancelled:
                    if (!cancelled) cancelled = [NSMutableSet set];
                    [cancelled addObject:touch];
                    break;
                default:
                    break;
            }
        }
        // call our methods to handle the touches
		for (GestureView* view in self.subviews){
			//NSLog(@"%@",view);
			
			if (began)     [view touchesBegan:began withEvent:event];
			if (moved)     [view touchesMoved:moved withEvent:event];
			if (ended)     [view touchesEnded:ended withEvent:event];
			if (cancelled) [view touchesCancelled:cancelled withEvent:event];
		}
	//}
    [super sendEvent:event];
}

#pragma mark GLGestureRecognizerDelegate

-(void)recognizerCallback:(NSString *)character{
	NSLog(@"recognize:%@",character);
	if (canvas.needSecondStroke) {
		textView.text = [textView.text stringByAppendingFormat:@"%d", canvas.needSecondStroke];
		canvas.needSecondStroke = 0;
	}
	else {
		if ([character isEqualToString:@"."]) {
			return;
		}
		else if ([character isEqualToString:@"4"]) {
			canvas.needSecondStroke = 4;
			return;
		}
		else if ([character isEqualToString:@"5"]) {
			canvas.needSecondStroke = 5;
			return;
		}
		else {
			textView.text = [textView.text stringByAppendingFormat:@"%@", character];
		}

	}
}


#pragma mark GestureViewDelegate

-(void) detectMove{
	moving = YES;
	[self bringSubviewToFront:canvas];
}
-(void) touchEnded{
	NSLog(@"Window touchEnded");
	if (!canvas.needSecondStroke) {
		[self bringSubviewToFront:mimicKeyboard];
	}
}



#pragma mark IBActions
- (IBAction)pushKey:(id)sender {
	UIButton* button = (UIButton*)sender;
	if (moving) {
		moving = NO;
		return;
	}
	if (shifted) {
		textView.text = [textView.text stringByAppendingFormat:@"%@",button.titleLabel.text];
		shifted = !shifted;
		[shift setImage:[UIImage imageNamed:@"shift.png"] forState:UIControlStateNormal];
	}
	else {
		textView.text = [textView.text stringByAppendingFormat:@"%@",[button.titleLabel.text lowercaseString]];
	}
    /*
    // When the accessory view button is tapped, add a suitable string to the text view.
    NSMutableString *text = [textView.text mutableCopy];
    NSRange selectedRange = textView.selectedRange;
    
    [text replaceCharactersInRange:selectedRange withString:@"m"];
    textView.text = text;
    [text release];
	 */
}
-(IBAction)backspace:(id)sender{
	if ( [textView.text length] > 0 )
		textView.text = [textView.text substringToIndex:[textView.text length] - 1];
}

-(IBAction)returnKey:(id)sender{
	textView.text = [textView.text stringByAppendingFormat:@"\n"];
}

-(IBAction)spaceKey:(id)sender{
	textView.text = [textView.text stringByAppendingFormat:@" "];

}
-(IBAction)shiftKey:(id)sender{
	shifted = !shifted;
	UIButton* button = (UIButton*)sender;
	if (shifted) {
		[button setImage:[UIImage imageNamed:@"shift_on.png"] forState:UIControlStateNormal];

	}
	else {
		[button setImage:[UIImage imageNamed:@"shift.png"] forState:UIControlStateNormal];
	}

}


@end
