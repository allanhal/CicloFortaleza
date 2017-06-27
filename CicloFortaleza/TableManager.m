//
//  TableManager.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 05/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "TableManager.h"
#import "Manager.h"
#import "ImagesUtil.h"
#import "CoordinateUtil.h"

@implementation TableManager

@synthesize tablePosition;
@synthesize tableList;
@synthesize tableView;

+ (TableManager *)instance
{
    static dispatch_once_t pred;
    static TableManager *sharedInstance = nil;
    
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    
    return sharedInstance;
}

- (id)init
{
    self.tableList = [[NSMutableArray alloc] init];
    self.tablePosition = TablePositionNone;
    return self;
}

- (void)changeToDefaultTablePosition
{
    [self changeTablePosition:tablePosition];
}

- (void)changeTablePosition:(TablePosition)aTablePosition
{
    CGFloat xPadding = 10;
    
    CGFloat x;
    CGFloat y;
    CGFloat width;
    CGFloat height;
    
    CGRect mainScreen = [UIScreen mainScreen].bounds;
    
    int mainScreenWidth = mainScreen.size.width;
    int mainScreenHeight = mainScreen.size.height;
    
    UIImage *baseImage = [ImagesUtil menuInferior];
    int baseHeight = baseImage.size.height;
    
    if(aTablePosition == TablePositionFull)
    {
        x = xPadding;
        y = 70;
        width = mainScreenWidth - (2*xPadding);
        height = (mainScreenHeight - y) - baseHeight;
    }
    else if(aTablePosition == TablePositionNone)
    {
        x = tableView.frame.origin.x;
        y = (mainScreenHeight) - baseHeight;
        width = mainScreenWidth - (2*xPadding);
        height = 0;
    }
    else if(aTablePosition == TablePositionBottom)
    {
        x = xPadding;
        //iPhone 5/5S
        y = 300;
        //iPhone 4/4S
        //y = 200;
        width = mainScreenWidth - (2*xPadding);
        height = (mainScreenHeight - y) - baseHeight;
    }
    else if(aTablePosition == TablePositionTop)
    {
        x = xPadding;
        y = 70;
        width = mainScreenWidth - xPadding;
        height = 250;
    }
    else
    {
        //TablePositionBottom
        x = xPadding;
        //iPhone 5/5S
        y = 300;
        //iPhone 4/4S
        //y = 200;
        width = mainScreenWidth - (2*xPadding);
        height = (mainScreenHeight - y) - baseHeight;
    }
    
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    [UIView animateWithDuration:0.4 animations:^{
        tableView.frame = tableFrame;
        [tableView setNeedsDisplay];
    }];
    
    [tableView reloadData];
}

- (NSArray *)remakeListBasedOnLocation
{    
    //Localização do Usuário
    CLLocationCoordinate2D userLocation = [[Manager positionManager] userCoordinate];
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:userLocation.latitude longitude:userLocation.longitude];
    
    NSArray *unorderedLocations = self.tableList;
    
    NSArray *sortedArray;
    sortedArray = [unorderedLocations sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        CLLocationCoordinate2D coordinateA = [(MKPointAnnotation*)a coordinate];
        CLLocationCoordinate2D coordinateB = [(MKPointAnnotation*)b coordinate];
        
        CLLocation *locationA = [[CLLocation alloc] initWithLatitude:coordinateA.latitude longitude:coordinateA.longitude];
        CLLocationDistance distanceToLocationA = [currentLocation distanceFromLocation:locationA];
        
        CLLocation *locationB = [[CLLocation alloc] initWithLatitude:coordinateB.latitude longitude:coordinateB.longitude];
        CLLocationDistance distanceToLocationB = [currentLocation distanceFromLocation:locationB];
        
        return distanceToLocationA > distanceToLocationB;
    }];
    
    return sortedArray;
}

@end
