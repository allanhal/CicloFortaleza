//
//  CoordinateUtil.h
//  CicloFortaleza
//
//  Created by Allan Araujo on 10/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CoordinateUtil : NSObject

+(CLLocationCoordinate2D)translateCoord:(CLLocationCoordinate2D)coord MetersLat:(double)metersLat MetersLong:(double)metersLong;

@end
