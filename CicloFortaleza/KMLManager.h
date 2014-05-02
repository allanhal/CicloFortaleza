//
//  KMLManager.h
//  KMLViewer
//
//  Created by Allan Araujo on 29/04/14.
//
//

#import <Foundation/Foundation.h>
#import "BasicManager.h"
#import "KMLParser.h"

@interface KMLManager : BasicManager

+ (KMLManager *)instance;
- (KMLParser *)retrieveKmlParsed;
- (void)updateKmlWithCompletionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

@end
