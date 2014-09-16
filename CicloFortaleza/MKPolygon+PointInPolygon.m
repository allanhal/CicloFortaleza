//
//  MKPolygon+PointInPolygon.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 15/09/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "MKPolygon+PointInPolygon.h"

@implementation MKPolygon (PointInPolygon)

-(BOOL)coordInPolygon:(CLLocationCoordinate2D)coord {
    
    MKMapPoint mapPoint = MKMapPointForCoordinate(coord);
    return [self pointInPolygon:mapPoint];
}

-(BOOL)pointInPolygon:(MKMapPoint)mapPoint {
    
    MKPolygonRenderer *polygonRenderer = [[MKPolygonRenderer alloc] initWithPolygon:self];
    CGPoint polygonViewPoint = [polygonRenderer pointForMapPoint:mapPoint];
    return CGPathContainsPoint(polygonRenderer.path, NULL, polygonViewPoint, NO);
}

@end
