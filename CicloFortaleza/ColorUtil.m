//
//  ColorUtil.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 04/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "ColorUtil.h"

@implementation ColorUtil

+(UIColor *)r:(float)r g:(float)g b:(float)b
{
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.00f];
}

@end
