//
//  FileManager.m
//  KMLViewer
//
//  Created by Allan Araujo on 29/04/14.
//
//

#import "KMLManager.h"
#import "Manager.h"

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
        //    path = [[NSBundle mainBundle] pathForResource:@"Mapa Cicloviário e de Rotas Alternativas de Fortaleza" ofType:@"kml"];
        path = [[NSBundle mainBundle] pathForResource:@"Tapioqueiras_até_Guaramiranga" ofType:@"kml"];
        
        lastUrl = [NSURL fileURLWithPath:path];
    }
    KMLParser *toReturn = [[KMLParser alloc] initWithURL:lastUrl];
    [toReturn parseKML];
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

@end
