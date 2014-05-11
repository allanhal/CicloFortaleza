//
//  CoordinateUtil.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 10/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "CoordinateUtil.h"

@implementation CoordinateUtil

+(CLLocationCoordinate2D)translateCoord:(CLLocationCoordinate2D)coord MetersLat:(double)metersLat MetersLong:(double)metersLong
{
    CLLocationCoordinate2D tempCoord;
    
    MKCoordinateRegion tempRegion = MKCoordinateRegionMakeWithDistance(coord, metersLat, metersLong);
    MKCoordinateSpan tempSpan = tempRegion.span;
    
    tempCoord.latitude = coord.latitude + tempSpan.latitudeDelta;
    tempCoord.longitude = coord.longitude + tempSpan.longitudeDelta;
    
    return tempCoord;
}

@end
