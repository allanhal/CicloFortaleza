//
//  CenterListViewController.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 02/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "CenterListViewController.h"
#import "CustomCell.h"
#import "ILTranslucentView.h"

@implementation CenterListViewController

@synthesize tableView;
@synthesize tablePosition;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self makeTableView];
}

-(void)makeTableView
{
    CGFloat x = 10;
    CGFloat y = 300;
    CGFloat width = 300;
    CGFloat height = 269;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.sectionFooterHeight = 0;
    tableView.sectionHeaderHeight = 0;
    tableView.showsVerticalScrollIndicator = NO;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
}

- (void)changeTablePosition:(TablePosition)aTablePosition
{
    CGFloat x;
    CGFloat y;
    CGFloat width;
    CGFloat height;
    
    if(aTablePosition == TablePositionFull)
    {
        x = 10;
        y = 70;
        width = 300;
        height = 499;
    }
    else if(aTablePosition == TablePositionNone)
    {
        x = 10;
        y = 70;
        width = 0;
        height = 0;
    }
    else if(aTablePosition == TablePositionBottom)
    {
        x = 10;
        y = 300;
        width = 300;
        height = 269;
    }
    else if(aTablePosition == TablePositionTop)
    {
        x = 10;
        y = 70;
        width = 300;
        height = 269;
    }
    else
    {
        x = 10;
        y = 300;
        width = 300;
        height = 269;
    }
    
    self.tablePosition = aTablePosition;
    
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    [UIView animateWithDuration:1 animations:^{
        self.tableView.frame = tableFrame;
        [self.tableView setNeedsDisplay];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    CustomCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.frame = CGRectMake(0, 0, aTableView.frame.size.width, 90);
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.cellLabel = [[UILabel alloc] initWithFrame:cell.frame];
        cell.cellLabel.backgroundColor = [UIColor clearColor];
        cell.cellLabel.textColor = [UIColor whiteColor];

        [cell addSubview:[self translucentView:cell.frame]];
        [cell addSubview:cell.cellLabel];
    }

    cell.cellLabel.text = [NSString stringWithFormat:@"%@ %d", @"Bicicletário ", (int)indexPath.section];
    
    return cell;
}

- (UIView *)translucentView:(CGRect)frame
{
    ILTranslucentView *translucentView = [[ILTranslucentView alloc] initWithFrame:frame];
    
    //optional:
    translucentView.translucentAlpha = 1;
    translucentView.translucentStyle = UIBarStyleBlack;
    translucentView.translucentTintColor = [UIColor clearColor];
    translucentView.backgroundColor = [UIColor clearColor];

    return translucentView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - Workaround para remover o Header e o Footer da tabela.

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

@end
