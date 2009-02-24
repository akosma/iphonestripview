//
//  StripView.m
//  StripTest
//
//  Created by Adrian on 2/24/09.
//  Copyright 2009 Adrian Kosmaczewski. All rights reserved.
//

#import "StripView.h"

#define STRIP_HEIGHT 40.0

@interface StripView (Private)
- (void)checkEdgesVisibilities;
- (void)resetAllButtons;
- (void)highlightButton:(UIButton *)button;
@end

@implementation StripView

@synthesize delegate;
@synthesize titles;
@synthesize font;

#pragma mark -
#pragma mark Constructor and destructor

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) 
    {
        font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        self.backgroundColor = [UIColor blackColor];

        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, STRIP_HEIGHT)];
        UIImage *backgroundImage = [UIImage imageNamed:@"strip_background.png"];
        backgroundView.image = backgroundImage;
        [backgroundImage release];
        [self addSubview:backgroundView];
        [backgroundView release];
        
        titlesView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, STRIP_HEIGHT)];
        titlesView.delegate = self;
        titlesView.pagingEnabled = NO;
        titlesView.showsHorizontalScrollIndicator = NO;
        titlesView.showsVerticalScrollIndicator = NO;
        titlesView.bounces = NO;
        [self addSubview:titlesView];
        
        // Add the overlapping image on the left of the scroller
        leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 25.0, STRIP_HEIGHT)];
        UIImage *leftImage = [UIImage imageNamed:@"strip_left.png"];
        leftView.image = leftImage;
        [leftImage release];
        leftView.hidden = YES;
        [self addSubview:leftView];
        
        // Add the overlapping image on the right of the scroller
        rightView = [[UIImageView alloc] initWithFrame:CGRectMake(295.0, 0.0, 25.0, STRIP_HEIGHT)];
        UIImage *rightImage = [UIImage imageNamed:@"strip_right.png"];
        rightView.image = rightImage;
        [rightImage release];
        [self addSubview:rightView];
    }
    return self;
}

- (void)dealloc 
{
    [titlesView release];
    [leftView release];
    [rightView release];
    [titles release];
    [buttons release];
    [font release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)setTitles:(NSArray *)newTitles
{
    if (newTitles != titles)
    {
        [titles release];
        titles = nil;
        titles = [newTitles retain];
        
        for (UIButton *button in buttons)
        {
            [button removeFromSuperview];
        }
        
        [buttons release];
        buttons = [[NSMutableArray alloc] initWithCapacity:[titles count]];
        
        titlesView.contentSize = CGSizeMake(0.0, 0.0);
        
        // Create a button for each title
        for (NSUInteger index = 0; index < [titles count]; ++index)
        {
            // Get the width of the text to add
            NSString *title = [titles objectAtIndex:index];
            CGSize size = [title sizeWithFont:font];
            
            // Increase the content size for the next button
            titlesView.contentSize = CGSizeMake(titlesView.contentSize.width + size.width + 35.0, STRIP_HEIGHT);
            
            // Create the button
            CGFloat position = titlesView.contentSize.width - size.width;
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(position, 11.0, size.width + 10.0, 20.0)];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
            button.backgroundColor = [UIColor clearColor];
            button.font = font;
            button.opaque = NO;
            button.tag = index;
            [titlesView addSubview:button];
            [buttons addObject:button];
            [button release];
        }
        // Increase the content size with some padding on the right
        titlesView.contentSize = CGSizeMake(titlesView.contentSize.width + 50.0, STRIP_HEIGHT);
        maxOffset = titlesView.contentSize.width - 320.0;
    }
}

- (void)showButtonWithIndex:(NSUInteger)index
{
    if (index < [titles count])
    {
        // To get the position of the button specified by the index,
        // we have to calculate the widths of all the individual titles.
        NSUInteger currentIndex = 0;
        CGFloat position = 0.0;
        CGRect rect = CGRectMake(0.0, 0.0, 320.0, STRIP_HEIGHT);
        while (currentIndex < index)
        {
            NSString *title = [titles objectAtIndex:currentIndex];
            CGSize size = [title sizeWithFont:font];
            position = position + size.width + 35.0;
            rect = CGRectMake(position, 0.0, 320.0, STRIP_HEIGHT);
            ++currentIndex;
        }
        
        [titlesView scrollRectToVisible:rect animated:YES];
        [self resetAllButtons];
        [self highlightButton:[buttons objectAtIndex:index]];
        [self checkEdgesVisibilities];
    }
}

#pragma mark -
#pragma mark Buttons event handler

- (void)buttonPressed:(id)sender
{
    [self resetAllButtons];
    [self highlightButton:sender];
    if ([delegate respondsToSelector:@selector(stripController:buttonTouched:)])
    {
        [delegate stripController:self buttonTouched:[sender tag]];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self checkEdgesVisibilities];
}

#pragma mark -
#pragma mark Private methods

- (void)checkEdgesVisibilities
{
    CGFloat xOffset = titlesView.contentOffset.x;
    leftView.hidden = (xOffset == 0.0);
    rightView.hidden = (xOffset == maxOffset);
}

- (void)resetAllButtons
{
    for (UIButton *button in buttons)
    {
        [button setSelected:NO];
        button.backgroundColor = [UIColor clearColor];
    }
}

- (void)highlightButton:(UIButton *)button
{
    [button setSelected:YES];
    [button setBackgroundColor:[UIColor blackColor]];
}

@end
