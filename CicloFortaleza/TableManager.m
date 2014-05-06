//
//  TableManager.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 05/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "TableManager.h"

@implementation TableManager

@synthesize tablePosition;

+ (TableManager *)instance
{
    static dispatch_once_t pred;
    static TableManager *sharedInstance = nil;
    
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    
    return sharedInstance;
}

- (id)init
{
    self.tablePosition = TablePositionBottom;
    return self;
}

@end
