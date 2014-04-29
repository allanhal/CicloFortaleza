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

- (void)makeRequest
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://example.com/resources.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)downloadKMLWithCompletionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://mapsengine.google.com/map/u/0/kml?mid=z8Q5SBXmCaP8.kSnFgQIIZDcU"];
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
