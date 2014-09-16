//
//  CenterViewController.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 02/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "CenterMapViewController.h"
#import "ZAActivityBar.h"
#import "CoordinateUtil.h"
#import "MKPolygon+PointInPolygon.h"

@implementation CenterMapViewController

@synthesize mapView;
@synthesize kmlParser;
@synthesize mainScreen;
@synthesize defaultPadding;
@synthesize userLocationButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainScreen = [[UIScreen mainScreen] bounds];
    defaultPadding = 10;
    
    [self mountMap];
    [self moveMapToUserLocation];
    [self loadInfo];
}

- (void)mountMap
{
    RMMapboxSource *tileSource = [[RMMapboxSource alloc] initWithMapID:@"allanhal.i50boh1n"];
    
    mapView = [[MapChanged alloc] initWithFrame:self.view.bounds andTilesource:tileSource];
    mapView.delegate = self;
    mapView.userTrackingMode = RMUserTrackingModeFollow;
    mapView.showsUserLocation = YES;
    mapView.zoom = 16;
    
    [self.view addSubview:mapView];
}

- (void)loadInfo
{
    [ZAActivityBar showWithStatus:@"Baixando mapa..."];
    
    [[Manager kmlManager] updateKmlWithCompletionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [self loadKml:error];
    }];
}

- (void)loadKml:(NSError *)error
{
    kmlParser = [[Manager kmlManager] retrieveKmlParsed];
    
    // Add all of the MKOverlay objects parsed from the KML file to the map.
    NSArray *overlays = [kmlParser overlays];
    
    MKPolygon *poly = [overlays objectAtIndex:0];
    
    BOOL inside = [poly coordInPolygon:self.mapView.userLocation.coordinate];
    
    
    // Add all of the MKAnnotation objects parsed from the KML file to the map.
    NSArray *annotations = [kmlParser points];
    for(MKPointAnnotation *point in annotations)
    {
        RMAnnotation *annotation = [[RMAnnotation alloc] initWithMapView:mapView
                                                              coordinate:point.coordinate
                                                                andTitle:point.title];
        [self.mapView addAnnotation:annotation];
    }
    
    if(error)
    {
        [ZAActivityBar showErrorWithStatus:@"Mapa desatualizado."];
    }
    else
    {
        [ZAActivityBar showSuccessWithStatus:@"Mapa carregado."];
    }
    
    [[Manager tableManager] changeToDefaultTablePosition];
}

- (void)moveMapToUserLocation
{
    [self moveMapToCoordinate:self.mapView.userLocation.coordinate];
}

- (void)moveMapToCoordinate:(CLLocationCoordinate2D)coordinate
{
    self.mapView.centerCoordinate = coordinate;
}

- (void)changeToFollow:(BOOL)follow
{
    if(follow)
    {
        self.mapView.userTrackingMode = RMUserTrackingModeFollow;
    }
    else
    {
        self.mapView.userTrackingMode = RMUserTrackingModeNone;
    }
}

#pragma mark RMMapViewDelegate

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    if (annotation.isUserLocationAnnotation)
        return nil;
    
    RMMarker *marker = [[RMMarker alloc] initWithUIImage:[ImagesUtil bicicletarioPequeno]];
    
    marker.canShowCallout = YES;
    
    return marker;
}

- (void)beforeMapMove:(RMMapView *)map byUser:(BOOL)wasUserAction
{
    if(wasUserAction)
    {
        UIImage *setaVazada = [ImagesUtil setaVazada];
        [self.userLocationButton setImage:setaVazada forState:UIControlStateNormal];
        [self changeToFollow:NO];
    }
}

- (void)mapView:(RMMapView *)mapView didChangeUserTrackingMode:(RMUserTrackingMode)mode animated:(BOOL)animated
{
    [self moveMapToUserLocation];
}

//Make list to be from the closest to the farthest
- (NSMutableArray *)remakeListBasedOnLocation1
{
    NSMutableArray *orderedListToReturn = [[NSMutableArray alloc] init];
    
    //Localização do Usuário
    CLLocationCoordinate2D userLocation = self.mapView.userLocation.coordinate;
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:userLocation.latitude longitude:userLocation.longitude];
    
    NSMutableArray *tableList = [Manager tableManager].tableList;
    for(MKPointAnnotation *newAnnotation in tableList)
    {
        //Quando a lista está vazia adicionamos 1 location
        if([orderedListToReturn count] == 0)
        {
            [orderedListToReturn addObject:newAnnotation];
        }
        else
        {
            int index = 0;
            for(MKPointAnnotation *orderedAnnotation in orderedListToReturn)
            {
                MKPointAnnotation *localAnnotation = [tableList objectAtIndex:index];
                
                CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:orderedAnnotation.coordinate.latitude longitude:orderedAnnotation.coordinate.longitude];
                CLLocationDistance distanceToNewLocation = [currentLocation distanceFromLocation:newLocation];
                
                CLLocation *localLocation = [[CLLocation alloc] initWithLatitude:localAnnotation.coordinate.latitude longitude:localAnnotation.coordinate.longitude];
                CLLocationDistance distanceToLocalLocation = [currentLocation distanceFromLocation:localLocation];
                
                if(distanceToNewLocation >= distanceToLocalLocation)
           
                {
                    [orderedListToReturn insertObject:newAnnotation atIndex:index];
                    break;
                }
                index++;
            }
        }
    }
    
    return orderedListToReturn;
}

- (NSMutableArray *)remakeListBasedOnLocation
{
    NSMutableArray *orderedListToReturn = [[NSMutableArray alloc] init];
    
    //Localização do Usuário
    CLLocationCoordinate2D userLocation = self.mapView.userLocation.coordinate;
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:userLocation.latitude longitude:userLocation.longitude];
    
    NSMutableArray *unorderedLocations = [Manager tableManager].tableList;
    for(MKPointAnnotation *originalUnorderedLocation in unorderedLocations)
    {
        // Quando a lista está vazia adicionamos 1 location
        if([orderedListToReturn count] == 0)
        {
            [orderedListToReturn addObject:[unorderedLocations objectAtIndex:0]];
        }
    }
    return orderedListToReturn;
}


@end
