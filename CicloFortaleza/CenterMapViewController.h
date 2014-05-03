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

@interface CenterMapViewController : MMDrawerController <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) KMLParser *kmlParser;

@end
