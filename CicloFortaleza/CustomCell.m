//
//  CustomCell.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 02/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize titleLabel;
@synthesize subtitleLabel;

-(void)addSubview:(UIView *)view
{
    // The separator has a height of 0.5pt on a retina display and 1pt on non-retina.
    // Prevent subviews with this height from being added.
    if (CGRectGetHeight(view.frame)*[UIScreen mainScreen].scale == 1)
    {
        return;
    }
    
    [super addSubview:view];
}

@end
