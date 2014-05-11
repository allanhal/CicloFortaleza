//
//  TableManager.h
//  CicloFortaleza
//
//  Created by Allan Araujo on 05/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicManager.h"

@interface TableManager : BasicManager

typedef NS_ENUM(NSInteger, TablePosition) {
    TablePositionTop,
    TablePositionBottom,
    TablePositionFull,
    TablePositionNone
};

@property (nonatomic) TablePosition tablePosition;
@property (strong, nonatomic) NSArray *tableList;

+ (TableManager *)instance;

@end
