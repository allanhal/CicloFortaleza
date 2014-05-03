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
    
//    tableView.layer.borderWidth = 1.0;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.sectionFooterHeight = 0;
    tableView.sectionHeaderHeight = 0;
    tableView.showsVerticalScrollIndicator = NO;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    CustomCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        [cell addSubview:[self translucentView:cell.frame]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cellLabel = [[UILabel alloc] initWithFrame:cell.frame];
        
        cell.cellLabel.backgroundColor = [UIColor clearColor];
        [cell.cellLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:cell.cellLabel];
        cell.backgroundColor = [UIColor clearColor];
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
    return 60;
}

#pragma mark - Workaround para remover o Header e o Footer da tabela.

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
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
