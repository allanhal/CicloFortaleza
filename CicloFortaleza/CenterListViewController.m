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

- (CustomCell *)createCell:(NSString *)cellIdentifier aTableView:(UITableView *)aTableView
{
    CustomCell *toReturn = [[CustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    toReturn.frame = CGRectMake(0, 0, aTableView.frame.size.width, 90);
    toReturn.backgroundColor = [UIColor clearColor];
    toReturn.selectionStyle = UITableViewCellSelectionStyleNone;
    
    toReturn.titleLabel = [[UILabel alloc] initWithFrame:toReturn.frame];
    toReturn.titleLabel.backgroundColor = [UIColor clearColor];
    toReturn.titleLabel.textColor = [UIColor whiteColor];
    
    [toReturn addSubview:[self translucentView:toReturn.frame]];
    [toReturn addSubview:toReturn.titleLabel];
    
    return toReturn;
}

- (CustomCell *)createNewCustomCell:(NSString *)cellIdentifier aTableView:(UITableView *)aTableView
{
    CustomCell *toReturn = [[CustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    toReturn.frame = CGRectMake(0, 0, aTableView.frame.size.width, 90);
    toReturn.backgroundColor = [UIColor clearColor];
    toReturn.selectionStyle = UITableViewCellSelectionStyleNone;
    
    toReturn.titleLabel = [[UILabel alloc] init];
    toReturn.titleLabel.backgroundColor = [UIColor clearColor];
    toReturn.titleLabel.textColor = [UIColor whiteColor];
    toReturn.titleLabel.frame = CGRectMake(0, 0, toReturn.frame.size.width-0, 22);
    toReturn.titleLabel.font = [UIFont fontWithDescriptor:[toReturn.titleLabel.font.fontDescriptor
                                                           fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold] size:0];
    
    toReturn.subtitleLabel = [[UITextView alloc] init];
    toReturn.subtitleLabel.backgroundColor = [UIColor clearColor];
    toReturn.subtitleLabel.textColor = [UIColor whiteColor];
    toReturn.subtitleLabel.frame = CGRectMake(-3, 15, toReturn.frame.size.width-0, toReturn.frame.size.height-10);
//    toReturn.subtitleLabel.layer.borderWidth = 2;
    toReturn.subtitleLabel.editable = NO;
    toReturn.subtitleLabel.selectable = NO;
    toReturn.subtitleLabel.scrollEnabled = NO;
    
    [toReturn addSubview:[self translucentView:toReturn.frame]];
    [toReturn addSubview:toReturn.titleLabel];
    [toReturn addSubview:toReturn.subtitleLabel];
    
    return toReturn;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    CustomCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [self createNewCustomCell:cellIdentifier  aTableView:aTableView];
    }

    NSMutableArray *list = [Manager tableManager].tableList;
    int row = (int)indexPath.section;
    if([list count] > 0 && [list count] > row)
    {
        MKPointAnnotation *pointAnnotation = [list objectAtIndex:row];
        cell.titleLabel.text = pointAnnotation.title;
        cell.subtitleLabel.text = pointAnnotation.subtitle;
        
        CLLocationCoordinate2D userLocation = [[Manager positionManager] userCoordinate];
        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:userLocation.latitude longitude:userLocation.longitude];
        
        CLLocation *cellLocation = [[CLLocation alloc] initWithLatitude:pointAnnotation.coordinate.latitude longitude:pointAnnotation.coordinate.longitude];
        CLLocationDistance distanceToNewLocation = [currentLocation distanceFromLocation:cellLocation];
        NSString *distance = [NSString stringWithFormat:@"Distância: %.2f KM\n", distanceToNewLocation/1000];
        
        cell.subtitleLabel.text = [distance stringByAppendingString:cell.subtitleLabel.text];
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
