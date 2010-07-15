//
//  GLGestureRecognizer.h
//  Gestures
//
//  Created by Adam Preble on 4/28/09.  adam@giraffelab.com
//

#import <Foundation/Foundation.h>
@protocol GLGestureRecognizerDelegate
-(void)recognizerCallback:(NSString*)character;
@end


@interface GLGestureRecognizer : NSObject {
	id<GLGestureRecognizerDelegate> delegate;
	NSMutableArray *touchPoints;
	NSMutableArray *resampledPoints;
	NSDictionary *templates;
}
@property (nonatomic, retain) id<GLGestureRecognizerDelegate> delegate;
@property (nonatomic, retain) NSDictionary *templates;
@property (nonatomic, retain) NSMutableArray *touchPoints;
@property (nonatomic, retain) NSArray *resampledPoints;
- (BOOL)loadTemplatesFromFile:(NSString*)path;
- (void)addTouches:(NSSet*)set fromView:(UIView *)view;
- (void)addTouchAtPoint:(CGPoint)point;
- (void)resetTouches;
- (NSString *)findBestMatch;
- (NSString *)findBestMatchCenter:(CGPoint*)outCenter angle:(float*)outRadians score:(float*)outScore;
@end
