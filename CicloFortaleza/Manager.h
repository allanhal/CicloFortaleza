//
//  Manager.h
//  KMLViewer
//
//  Created by Allan Araujo on 29/04/14.
//
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"
#import "KMLManager.h"
#import "TableManager.h"
#import "LocationManager.h"

@interface Manager : NSObject

+(RequestManager *)requestManager;
+(KMLManager *)kmlManager;
+(TableManager *)tableManager;
+(LocationManager *)locationManager;

@end
