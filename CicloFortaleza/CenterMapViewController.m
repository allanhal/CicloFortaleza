//
//  CenterViewController.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 02/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "CenterMapViewController.h"
#import "ZAActivityBar.h"

@implementation CenterMapViewController

@synthesize mapView;
@synthesize kmlParser;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self mountMap];
    [self loadInfo];
}

- (void)mountMap
{
    RMMapboxSource *tileSource = [[RMMapboxSource alloc] initWithMapID:@"allanhal.i50boh1n"];
    
    mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:tileSource];
    mapView.delegate = self;
    mapView.userTrackingMode = MKUserTrackingModeNone;
    mapView.showsUserLocation = YES;
    
    [self.view addSubview:mapView];
}

- (void)loadInfo
{
    NSLog(@"Baixando mapa...");
    [ZAActivityBar showWithStatus:@"Baixando mapa..."];
    
    [[Manager kmlManager] updateKmlWithCompletionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [self loadKml];
    }];
}

- (void)loadKml
{
    kmlParser = [[Manager kmlManager] retrieveKmlParsed];
    
    // Add all of the MKOverlay objects parsed from the KML file to the map.
    NSArray *overlays = [kmlParser overlays];
    
    // Add all of the MKAnnotation objects parsed from the KML file to the map.
    NSArray *annotations = [kmlParser points];
    for(MKPointAnnotation *point in annotations)
    {
        RMPointAnnotation *annotation = [[RMPointAnnotation alloc] initWithMapView:mapView
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
    
    [ZAActivityBar showSuccessWithStatus:@"Mapa carregado." duration:0.1f];
}

#pragma mark MKMapViewDelegate

@end
