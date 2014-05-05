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
#import "Manager.h"

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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[[Manager kmlManager] kmlAddress]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if(completionHandler)
        {
            completionHandler(response, filePath, error);
        }
    }];
    [downloadTask resume];
}

@end
