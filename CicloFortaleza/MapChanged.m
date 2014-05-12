//
//  MapChanged.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 11/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "MapChanged.h"

@implementation MapChanged

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
{
    if([Manager tableManager].tablePosition == TablePositionBottom)
    {
        centerCoordinate = [CoordinateUtil translateCoord:centerCoordinate MetersLat:-200 MetersLong:0];
    }
    [super setCenterCoordinate:centerCoordinate];
}

- (void)setCenterCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated
{
    if([Manager tableManager].tablePosition == TablePositionBottom)
    {
        coordinate = [CoordinateUtil translateCoord:coordinate MetersLat:-200 MetersLong:0];
    }
    
    [super setCenterCoordinate:coordinate animated:animated];
}

@end
