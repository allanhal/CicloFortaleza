//
//  LocationManager.h
//  CicloFortaleza
//
//  Created by Allan Araújo on 11/24/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BasicManager.h"

@interface LocationManager : BasicManager <CLLocationManagerDelegate>

@property (readonly, nonatomic) CLLocationManager *locationManager;

+ (LocationManager *)instance;

- (void)startUpdateGPS;

@end
