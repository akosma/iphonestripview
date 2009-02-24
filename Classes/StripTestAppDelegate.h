//
//  StripTestAppDelegate.h
//  StripTest
//
//  Created by Adrian on 2/24/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StripViewDelegate.h"

@class StripView;

@interface StripTestAppDelegate : NSObject <UIApplicationDelegate, StripViewDelegate> 
{
@private
    IBOutlet UIWindow *window;
    UIView *view;
    UILabel *label;
    UIButton *button;
    StripView *stripView;
    NSArray *titles;
}

@end
