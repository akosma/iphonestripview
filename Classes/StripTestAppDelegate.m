//
//  StripTestAppDelegate.m
//  StripTest
//
//  Created by Adrian on 2/24/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "StripTestAppDelegate.h"
#import "StripView.h"

@implementation StripTestAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    titles = [[NSArray alloc] initWithObjects:@"Argentina", @"Bolivia", @"Brazil", @"Chile", 
              @"Colombia", @"Ecuador", @"Paraguay", @"Peru", @"Uruguay", @"Venezuela", nil];

    view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 460.0)];
    
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 20.0, 320.0, 44.0)];
    [view addSubview:bar];
    [bar release];

    stripView = [[StripView alloc] initWithFrame:CGRectMake(0.0, 64.0, 320.0, 40.0)];
    stripView.delegate = self;
    stripView.titles = titles;
    [view addSubview:stripView];

    label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 130.0, 300.0, 50.0)];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    label.textAlignment = UITextAlignmentCenter;
    label.numberOfLines = 0;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.text = @"Select a country in the strip";
    [view addSubview:label];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self 
               action:@selector(showArgentina:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Show Argentina" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [view addSubview:button];
    
    [window addSubview:view];
    [window makeKeyAndVisible];
}

- (void)dealloc 
{
    [button release];
    [titles release];
    [stripView release];
    [view release];
    [label release];
    [window release];
    [super dealloc];
}

#pragma mark -
#pragma mark Button handler

- (void)showArgentina:(id)sender
{
    [stripView showButtonWithIndex:0];
}

#pragma mark -
#pragma mark StripViewDelegate methods

- (void)stripController:(StripView *)controller buttonTouched:(NSUInteger)buttonIndex
{
    label.text = [NSString stringWithFormat:@"Button selected in the strip: %d\nCountry: %@", buttonIndex, [titles objectAtIndex:buttonIndex]];
}

@end
