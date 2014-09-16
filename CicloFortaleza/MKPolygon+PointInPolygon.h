//
//  MKPolygon+PointInPolygon.h
//  CicloFortaleza
//
//  Created by Allan Araujo on 15/09/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKPolygon (PointInPolygon)

-(BOOL)coordInPolygon:(CLLocationCoordinate2D)coord;
-(BOOL)pointInPolygon:(MKMapPoint)point;

@end
