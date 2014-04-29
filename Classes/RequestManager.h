//
//  RequestManager.h
//  KMLViewer
//
//  Created by Allan Araújo on 4/23/14.
//
//

#import <Foundation/Foundation.h>
#import "BasicManager.h"

@interface RequestManager : BasicManager

+ (RequestManager *)instance;

- (void)makeRequest;
- (void)downloadKMLWithCompletionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

@end
