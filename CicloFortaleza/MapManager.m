//
//  MapManager.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 15/09/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "MapManager.h"

@implementation MapManager

+ (MapManager *)instance
{
    static dispatch_once_t pred;
    static MapManager *sharedInstance = nil;
    
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    
    return sharedInstance;
}


@end
