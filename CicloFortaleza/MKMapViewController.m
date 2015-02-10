//
//  MKMapViewController.m
//  CicloFortaleza
//
//  Created by Allan Araújo on 11/24/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "MKMapViewController.h"
#import "ZAActivityBar.h"
#import "Manager.h"

@implementation MKMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self mountMap];
    [self loadInfo];
    
    [self zoomToCurrentLocation];
}

- (void)mountMap
{
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    self.searchButton.hidden = YES;
}

- (void)zoomToCurrentLocation
{
    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion region;
    region.center.latitude = self.mapView.userLocation.coordinate.latitude;
    region.center.longitude = self.mapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    self.searchButton.hidden = YES;
    [self.mapView setRegion:region animated:YES];
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
    /*
    kmlParser = [[Manager kmlManager] retrieveKmlParsed];
    
    // Add all of the MKOverlay objects parsed from the KML file to the map.
    NSArray *overlays = [kmlParser overlays];
    
    // Add all of the MKAnnotation objects parsed from the KML file to the map.
    NSArray *annotations = [kmlParser points];
    for(MKPointAnnotation *point in annotations)
    {
        RMAnnotation *annotation = [[RMAnnotation alloc] initWithMapView:mapView
                                                              coordinate:point.coordinate
                                                                andTitle:point.title];
        [self.mapView addAnnotation:annotation];
    }
    
    // Walk the list of overlays and annotations and create a MKMapRect that
    // bounds all of them and store it into flyTo.
    MKMapRect flyTo = MKMapRectNull;
    for (id <MKOverlay> overlay in overlays) {
        if (MKMapRectIsNull(flyTo)) {
            flyTo = [overlay boundingMapRect];
        } else {
            flyTo = MKMapRectUnion(flyTo, [overlay boundingMapRect]);
        }
    }
    
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    if(error)
    {
        [ZAActivityBar showErrorWithStatus:@"Mapa desatualizado."];
    }
    else
    {
        [ZAActivityBar showSuccessWithStatus:@"Mapa carregado."];
    }
     */
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.searchButton.hidden = NO;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

@end
