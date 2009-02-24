//
//  StripViewDelegate.h
//  StripTest
//
//  Created by Adrian on 2/24/09.
//  Copyright 2009 Adrian Kosmaczewski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StripView;

@protocol StripViewDelegate

@required
- (void)stripController:(StripView *)controller buttonTouched:(NSUInteger)buttonIndex;

@end
