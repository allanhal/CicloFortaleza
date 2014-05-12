//
//  FileManager.m
//  KMLViewer
//
//  Created by Allan Araujo on 29/04/14.
//
//

#import "KMLManager.h"
#import "Manager.h"
#import <MapKit/MKAnnotation.h>

@implementation KMLManager

static NSURL *lastUrl = nil;

+ (KMLManager *)instance
{
    static dispatch_once_t pred;
    static KMLManager *sharedInstance = nil;
    
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    
    return sharedInstance;
}

- (KMLParser *)retrieveKmlParsed
{
    if(!lastUrl)
    {
        // Locate the path to the .kml file in the application's bundle
        // and parse it with the KMLParser.
        NSString *path;
        //    path = [[NSBundle mainBundle] pathForResource:@"KML_Sample" ofType:@"kml"];
        path = [[NSBundle mainBundle] pathForResource:@"Mapa Cicloviário e de Rotas Alternativas de Fortaleza" ofType:@"kml"];
        
        lastUrl = [NSURL fileURLWithPath:path];
    }
    KMLParser *toReturn = [[KMLParser alloc] initWithURL:lastUrl];
    [toReturn parseKML];
    
    for(MKPointAnnotation *annotation in [toReturn points])
    {
        NSLog(@"%@", annotation.title);
        [[Manager tableManager].tableList addObject:annotation];
    }
    
    return toReturn;
}

- (void)updateKmlWithCompletionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    [[Manager requestManager] downloadKMLWithCompletionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        lastUrl = filePath;
        if(completionHandler)
        {
            completionHandler(response, filePath, error);
        }
    }];
}

- (NSURL *)kmlFelipeAlves
{
    NSURL *URL = [NSURL URLWithString:@"http://mapsengine.google.com/map/u/0/kml?mid=z8Q5SBXmCaP8.kSnFgQIIZDcU"];
    return URL;
}

- (NSURL *)kmlGolbery
{
    NSURL *URL = [NSURL URLWithString:@"https://maps.google.com/maps/ms?dg=feature&ie=UTF8&authuser=0&msa=0&output=kml&msid=204779182148563529295.0004c1d9f57a7cb85f31d"];
    return URL;
}

- (NSURL *)kmlAddress
{
    return [self kmlFelipeAlves];
}

@end
