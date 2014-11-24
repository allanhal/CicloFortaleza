//
//  LocationManager.m
//  CicloFortaleza
//
//  Created by Allan Araújo on 11/24/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

@synthesize locationManager;

+ (LocationManager *)instance
{
    static dispatch_once_t pred;
    static LocationManager *sharedInstance = nil;
    
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    
    return sharedInstance;
}

- (id)init
{
    if (self = [super init])
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.pausesLocationUpdatesAutomatically = NO;
        locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        locationManager.distanceFilter = 50.0f;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    
    return self;
}

- (void)startUpdateGPS
{
    [locationManager requestAlwaysAuthorization];
}

@end
