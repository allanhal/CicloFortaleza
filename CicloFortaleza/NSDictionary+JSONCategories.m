//
//  NSDictionary+JSONCategories.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 15/09/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "NSDictionary+JSONCategories.h"

@implementation NSDictionary(JSONCategories)

+ (NSDictionary *)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString: urlAddress]];
    
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil)
        return nil;
    
    return result;
}

+ (NSDictionary *)dictionaryFromJSONString:(NSString *)jsonString
{
    return [self dictionaryFromJSONData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSDictionary *)dictionaryFromJSONData:(NSData *)jsonData
{
    if (!jsonData)
        return nil;
    
    NSError* error;
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    return (error != nil ? nil : dictionary);
}

- (NSData *)toJSONData
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    if (error != nil)
        return nil;
    
    return result;
}

- (NSString *)toJSONString
{
    return [[NSString alloc] initWithData:[self toJSONData] encoding:NSUTF8StringEncoding];
}

@end
