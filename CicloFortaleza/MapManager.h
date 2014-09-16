//
//  MapManager.h
//  CicloFortaleza
//
//  Created by Allan Araujo on 15/09/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicManager.h"
#import "MapChanged.h"

@interface MapManager : BasicManager

//@property (strong, nonatomic) MapChanged *mapView;

+ (MapManager *)instance;

@end
