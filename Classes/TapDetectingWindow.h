//
//  TapDetectingWindow.h
//  Multitouch_v1
//
//  Created by 鄭  龍磻 on 2010/5/16.
//  Copyright 2010  NTU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TapDetectingWindowDelegate
- (void)userDidTapWebView:(id)tapPoint;
@end

@interface TapDetectingWindow : UIWindow {
    UIView *viewToObserve;
    id <TapDetectingWindowDelegate> controllerThatObserves;
}

@property (nonatomic, retain) UIView *viewToObserve;
@property (nonatomic, assign) id <TapDetectingWindowDelegate> controllerThatObserves;
@end
