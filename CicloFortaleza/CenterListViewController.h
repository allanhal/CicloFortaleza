//
//  CenterListViewController.h
//  CicloFortaleza
//
//  Created by Allan Araujo on 02/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "CenterMapViewController.h"

@interface CenterListViewController : CenterMapViewController <UITableViewDataSource, UITableViewDelegate>

typedef NS_ENUM(NSInteger, TablePosition) {
    TablePositionTop,
    TablePositionBottom,
    TablePositionFull,
    TablePositionNone
};

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic) TablePosition tablePosition;

- (void)changeToDefaultTablePosition;
- (void)changeTablePosition:(TablePosition)aTablePosition;

@end
