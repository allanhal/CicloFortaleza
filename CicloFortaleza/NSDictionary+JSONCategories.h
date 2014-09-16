//
//  NSDictionary+JSONCategories.h
//  CicloFortaleza
//
//  Created by Allan Araujo on 15/09/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(JSONCategories)

+ (NSDictionary *)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
+ (NSDictionary *)dictionaryFromJSONString:(NSString *)jsonString;
+ (NSDictionary *)dictionaryFromJSONData:(NSData *)jsonData;
- (NSData *)toJSONData;
- (NSString *)toJSONString;

@end