//
//  RequestManager.h
//  KMLViewer
//
//  Created by Allan Araújo on 4/23/14.
//
//

#import <Foundation/Foundation.h>
#import "BasicManager.h"
#import <CoreLocation/CoreLocation.h>

@interface RequestManager : BasicManager

+ (RequestManager *)instance;

- (void)downloadKMLWithCompletionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

- (void)getDistanceFromCurrentLocationToAddress:(NSString *)address;

- (void)getDistanceFrom:(CLLocationCoordinate2D)coordinateFrom ToAddress:(NSString *)address;

@end
