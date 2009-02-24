//
//  StripView.h
//  StripTest
//
//  Created by Adrian on 2/24/09.
//  Copyright 2009 Adrian Kosmaczewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StripViewDelegate.h"

@interface StripView : UIView <UIScrollViewDelegate>
{
@private
    UIScrollView *titlesView;
    UIImageView *leftView;
    UIImageView *rightView;
    NSArray *titles;
    NSMutableArray *buttons;
    UIFont *font;
    NSObject<StripViewDelegate> *delegate;
    CGFloat maxOffset;
}

@property (nonatomic, assign) NSObject<StripViewDelegate> *delegate;
@property (nonatomic, retain) NSArray *titles;
@property (nonatomic, retain) UIFont *font;

- (void)showButtonWithIndex:(NSUInteger)index;

@end
