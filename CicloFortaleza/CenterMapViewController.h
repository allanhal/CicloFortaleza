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
#import "MapChanged.h"

@interface CenterMapViewController : MMDrawerController <CLLocationManagerDelegate, RMMapViewDelegate>

@property (strong, nonatomic) MapChanged *mapView;
@property (strong, nonatomic) KMLParser *kmlParser;
@property (nonatomic) CGRect mainScreen;
@property (nonatomic) CGFloat defaultPadding;
@property (strong, nonatomic) UIButton *userLocationButton;
@property (nonatomic) BOOL follow;

- (void)moveMapToUserLocation;
- (void)moveMapToCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)changeToFollow:(BOOL)follow;

@end
