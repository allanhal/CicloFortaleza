//
//  PositionManager.m
//  CicloFortaleza
//
//  Created by Allan Araújo on 5/14/15.
//  Copyright (c) 2015 Allan Araujo. All rights reserved.
//

#import "PositionManager.h"

@implementation PositionManager

@synthesize locationManager;

+ (PositionManager *)instance
{
    static dispatch_once_t pred;
    static PositionManager *sharedInstance = nil;
    
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    
    return sharedInstance;
}

- (id)init
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if(([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0))
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    
    return self;
}

- (void)startUpdatingLocation
{
    [self.locationManager startUpdatingLocation];
}

- (CLLocationCoordinate2D)userCoordinate
{
    return self.locationManager.location.coordinate;
}

@end
