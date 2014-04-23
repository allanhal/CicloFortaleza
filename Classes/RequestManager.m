//
//  RequestManager.m
//  KMLViewer
//
//  Created by Allan Araújo on 4/23/14.
//
//

#import "RequestManager.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>


@implementation RequestManager

+ (RequestManager *)sharedInstance
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
@end
