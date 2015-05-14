//
//  PositionManager.h
//  CicloFortaleza
//
//  Created by Allan Araújo on 5/14/15.
//  Copyright (c) 2015 Allan Araujo. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BasicManager.h"
#import <CoreLocation/CoreLocation.h>

@interface PositionManager : BasicManager <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

+ (PositionManager *)instance;

- (void)startUpdatingLocation;

- (CLLocationCoordinate2D)userCoordinate;

@end
