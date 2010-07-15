//
//  GestureView.m
//  Gestures
//
//  Created by Adam Preble on 4/27/09.
//  Copyright 2009 Giraffe Lab. All rights reserved.
//

#import "GestureView.h"

@implementation GestureView

@synthesize delegate;
@synthesize caption;
@synthesize recognizer;
@synthesize center;
@synthesize score;
@synthesize angle;
@synthesize preTouchPoints;
@synthesize needSecondStroke;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		needSecondStroke = 0;
    }
    return self;
}

- (void)dealloc {
	self.caption = nil;
	[recognizer release];
	[preTouchPoints release];
    [super dealloc];
}

- (void)awakeFromNib
{
	recognizer = [[GLGestureRecognizer alloc] init];
	[recognizer loadTemplatesFromFile:[[NSBundle mainBundle] pathForResource:@"Gestures" ofType:@"json"]];
	
	self.caption = @"";
}

- (void)drawRect:(CGRect)rect 
{
    // Drawing code
	//NSLog(@"caption: %@",caption);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	/*
	CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
	CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
	CGContextFillRect(ctx, rect);*/
	/*
	// draw text area
	CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
	CGContextSetTextDrawingMode(ctx, kCGTextFillStroke); 
	CGContextSelectFont(ctx, "Helvetica", 20, kCGEncodingMacRoman);
	CGContextSetTextMatrix(ctx, CGAffineTransformMakeScale(1, -1));
	CGContextShowTextAtPoint(ctx, 10, 30, [caption UTF8String], [caption length]);
	*/
	CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
	
	// add by dm4
	if (needSecondStroke) {
		NSLog(@"draw need");
		for (NSValue *pointValue in preTouchPoints) {
			CGPoint pointInView = [pointValue CGPointValue];
			if (pointValue == [preTouchPoints objectAtIndex:0])
				CGContextMoveToPoint(ctx, pointInView.x, pointInView.y);
			else
				CGContextAddLineToPoint(ctx, pointInView.x, pointInView.y);
		}
	}
	CGContextStrokePath(ctx);
	// add by dm4 END

	// draw stroke
	for (NSValue *pointValue in [recognizer touchPoints])
	{
		CGPoint pointInView = [pointValue CGPointValue];
		if (pointValue == [[recognizer touchPoints] objectAtIndex:0])
			CGContextMoveToPoint(ctx, pointInView.x, pointInView.y);
		else
			CGContextAddLineToPoint(ctx, pointInView.x, pointInView.y);
	}
	CGContextStrokePath(ctx);
	
	//draw samples
	/*
	CGContextSetRGBStrokeColor(ctx, 0, 1, 0, 1);
	for (NSValue *pointValue in [recognizer resampledPoints])
	{
		CGPoint pointInView = [pointValue CGPointValue];
		pointInView.x = pointInView.x * 100.0f + 160.0f;
		pointInView.y = pointInView.y * 100.0f + 240.0f;
		if (pointValue == [[recognizer resampledPoints] objectAtIndex:0])
			CGContextMoveToPoint(ctx, pointInView.x, pointInView.y);
		else
			CGContextAddLineToPoint(ctx, pointInView.x, pointInView.y);
	}
	CGContextStrokePath(ctx);
	
	CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
	CGContextFillRect(ctx, CGRectMake(center.x, center.y, 4.0f, 4.0f));
	 */
}
/*
- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	return nil;
}*/

- (void)processGestureData
{
	NSString *gestureName = [recognizer findBestMatchCenter:&center angle:&angle score:&score];
	self.caption = [NSString stringWithFormat:@"%@ (%0.2f, %d)", gestureName, score, (int)(360.0f*angle/(2.0f*M_PI))];
	NSLog(@"%@", self.caption);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touchbegan:%@",self.superview);
	[recognizer addTouches:touches fromView:self];
	[[self nextResponder] touchesBegan:touches withEvent:event];
	//NSLog(@"%@", [self nextResponder]);
	[self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[delegate detectMove];
	[recognizer addTouches:touches fromView:self];
	[self.nextResponder touchesMoved:touches withEvent:event];
	[self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[recognizer addTouches:touches fromView:self];	
	[self processGestureData];
	self.preTouchPoints = [recognizer touchPoints];
	[recognizer resetTouches];
	[delegate touchEnded];
	[self.nextResponder touchesEnded:touches withEvent:event];
	[self setNeedsDisplay];
}


@end
