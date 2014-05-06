//
//  CenterListViewController.h
//  CicloFortaleza
//
//  Created by Allan Araujo on 02/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "CenterMapViewController.h"

@interface CenterListViewController : CenterMapViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

- (void)changeToDefaultTablePosition;
- (void)changeTablePosition:(TablePosition)aTablePosition;

@end
