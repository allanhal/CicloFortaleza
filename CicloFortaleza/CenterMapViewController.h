//
//  CenterViewController.h
//  CicloFortaleza
//
//  Created by Allan Araujo on 02/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "KMLParser.h"
#import "Manager.h"
#import "MMDrawerController.h"
#import <Mapbox/Mapbox.h>
#import "ImagesUtil.h"

@interface CenterMapViewController : MMDrawerController <RMMapViewDelegate>

@property (strong, nonatomic) RMMapView *mapView;
@property (strong, nonatomic) KMLParser *kmlParser;
@property (nonatomic) CGRect mainScreen;
@property (nonatomic) CGFloat defaultPadding;

- (void)moveMapToUserLocation;
- (void)moveMapToCoordinate:(CLLocationCoordinate2D)coordinate;

@end
