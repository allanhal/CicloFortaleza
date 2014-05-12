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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self makeTableView];
}

-(void)makeTableView
{
    CGFloat x = 10;
    CGFloat y = 300;
    CGFloat width = 0;
    CGFloat height = 0;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    [Manager tableManager].tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    [self changeToDefaultTablePosition];
    
    [Manager tableManager].tableView.backgroundColor = [UIColor clearColor];
    [Manager tableManager].tableView.sectionFooterHeight = 0;
    [Manager tableManager].tableView.sectionHeaderHeight = 0;
    [Manager tableManager].tableView.showsVerticalScrollIndicator = NO;
    
    [Manager tableManager].tableView.delegate = self;
    [Manager tableManager].tableView.dataSource = self;
    
    [self.view addSubview:[Manager tableManager].tableView];
}

- (void)changeToDefaultTablePosition
{
    [self changeTablePosition:[Manager tableManager].tablePosition];
}

- (void)changeTablePosition:(TablePosition)aTablePosition
{
    [[Manager tableManager] changeTablePosition:aTablePosition];
    [self moveMapToUserLocation];
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
    NSMutableArray *list = [Manager tableManager].tableList;
    int row = (int)indexPath.section;
    if([list count] > 0)
    {
        MKPointAnnotation *pointAnnotation = [list objectAtIndex:row];
        cell.cellLabel.text = pointAnnotation.title;
    }
    
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
    int count = [[Manager tableManager].tableList count];
    return count > 0 ? count : 0;
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
