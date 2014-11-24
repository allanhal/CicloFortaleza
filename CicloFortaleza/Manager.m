//
//  Manager.m
//  KMLViewer
//
//  Created by Allan Araujo on 29/04/14.
//
//

#import "Manager.h"

@implementation Manager

+(RequestManager *)requestManager
{
    return [RequestManager instance];
}

+(KMLManager *)kmlManager;
{
    return [KMLManager instance];
}

+(TableManager *)tableManager;
{
    return [TableManager instance];
}

+(LocationManager *)locationManager;
{
    return [LocationManager instance];
}

@end
