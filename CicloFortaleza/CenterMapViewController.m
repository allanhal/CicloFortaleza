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

@implementation CenterMapViewController

@synthesize mapView;
@synthesize kmlParser;
@synthesize mainScreen;
@synthesize defaultPadding;

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
    
    mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:tileSource];
    mapView.delegate = self;
//    mapView.userTrackingMode = MKUserTrackingModeFollow;
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
    
    // Add all of the MKAnnotation objects parsed from the KML file to the map.
    NSArray *annotations = [kmlParser points];
    for(MKPointAnnotation *point in annotations)
    {
//        NSLog(@"%@",placemark);
//        CLLocationCoordinate2D aCoordinate = [[placemark point].coordinate;
        
//        KMLStyle *style;
//        KMLGeometry *geometry;
//        
//        NSString *name;
//        NSString *placemarkDescription;
//        
//        NSString *styleUrl;
//        
//        MKShape *mkShape;
//        
//        MKAnnotationView *annotationView;
//        MKOverlayPathView *overlayView;
        
//        NSString *title = NSString stringWithFormat:@"%@ %@", point.title, point.
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
}

- (void)moveMapToUserLocation
{
    [self moveMapToCoordinate:self.mapView.userLocation.coordinate];
}

- (void)moveMapToCoordinate:(CLLocationCoordinate2D)coordinate
{
    if([Manager tableManager].tablePosition == TablePositionBottom)
    {
        coordinate = [CoordinateUtil translateCoord:coordinate MetersLat:-200 MetersLong:0];
    }
    self.mapView.centerCoordinate = coordinate;
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

- (void)afterMapMove:(RMMapView *)map byUser:(BOOL)wasUserAction
{
    if(wasUserAction)
    {
        self.mapView.userTrackingMode = RMUserTrackingModeNone;
    }
}

- (void)mapView:(RMMapView *)mapView didUpdateUserLocation:(RMUserLocation *)userLocation
{
    [self moveMapToCoordinate:userLocation.coordinate];
}

//- (void)mapView:(RMMapView *)mapView didChangeUserTrackingMode:(RMUserTrackingMode)mode animated:(BOOL)animated
//{
//    [self moveMapToCoordinate:self.mapView.userLocation.coordinate];
//}

@end
