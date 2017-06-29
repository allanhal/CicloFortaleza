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
#import "SSZipArchive.h"

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
    NSArray *points = [toReturn points];
    for(MKPointAnnotation *annotation in points)
    {
        [self insertOnTableList:annotation];
    }
    
    return toReturn;
}

- (void)insertOnTableList:(MKPointAnnotation *)annotation
{
    [[Manager tableManager].tableList addObject:annotation];
}

- (void)updateKmlWithCompletionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    [[Manager requestManager] downloadKMLWithCompletionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        lastUrl = [self unzipFile:filePath];

        if(completionHandler)
        {
            completionHandler(response, filePath, error);
        }
    }];
}

- (NSURL *)unzipFile:(NSURL *)filePath
{
    // Unzipping
    //@"path_to_your_zip_file";
    NSString *zipPath = filePath.path;
    
    //@"path_to_the_folder_where_you_want_it_unzipped";
    NSString *destinationPath = [filePath.path stringByAppendingString:@"unzip"];
    
    [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
    
    //NSArray *filesAtPath = [self listFileAtPath:destinationPath];
    
    destinationPath = [destinationPath stringByAppendingString:@"/doc.kml"];
    return [NSURL fileURLWithPath:destinationPath];
}

-(NSArray *)listFileAtPath:(NSString *)path
{
    //-----> LIST ALL FILES <-----//
    NSLog(@"LISTING ALL FILES FOUND");
    
    int count;
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    for (count = 0; count < (int)[directoryContent count]; count++)
    {
        NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
    }
    return directoryContent;
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
