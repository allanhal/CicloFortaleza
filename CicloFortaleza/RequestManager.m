//
//  RequestManager.m
//  KMLViewer
//
//  Created by Allan Araújo on 4/23/14.
//
//

#import "RequestManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLSessionManager.h"

@implementation RequestManager

+ (RequestManager *)instance
{
    static dispatch_once_t pred;
    static RequestManager *sharedInstance = nil;
    
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    
    return sharedInstance;
}

- (void)downloadKMLWithCompletionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL;
//    Felipe Alves
//    URL = [NSURL URLWithString:@"http://mapsengine.google.com/map/u/0/kml?mid=z8Q5SBXmCaP8.kSnFgQIIZDcU"];
//    Golbery
    URL = [NSURL URLWithString:@"https://maps.google.com/maps/ms?dg=feature&ie=UTF8&authuser=0&msa=0&output=kml&msid=204779182148563529295.0004c1d9f57a7cb85f31d"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if(completionHandler)
        {
            completionHandler(response, filePath, error);
        }
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

@end
