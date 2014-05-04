//
//  LeftViewController.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 02/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "LeftViewController.h"
#import "MBSwitch.h"

@implementation LeftViewController

@synthesize topLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self mountLabel:@"Categoria 1" withPosition:1];

    [self mountLabel:@"Categoria 2" withPosition:2];
    [self mountBoolWithPosition:2];
    
    [self mountLabel:@"Categoria 3" withPosition:3];
    
    [self mountLabel:@"Categoria 4" withPosition:4];
    [self mountBoolWithPosition:4];
    
    [self mountLabel:@"Categoria 1" withPosition:5];
    
    [self mountLabel:@"Categoria 2" withPosition:6];
    
    [self mountLabel:@"Categoria 3" withPosition:7];
    
    [self mountLabel:@"Categoria 4" withPosition:8];
}

- (void)mountLabel:(NSString *)text withPosition:(int)position
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, position*50, 100, 20)];
    label.text = text;
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor redColor];
    
    [self.view addSubview:label];
}

- (void)mountBoolWithPosition:(int)position
{
    MBSwitch *aSwitch = [[MBSwitch alloc] initWithFrame:CGRectMake(205, position*50, 100, 20)];
    [aSwitch setTintColor:[UIColor colorWithRed:0.58f green:0.65f blue:0.65f alpha:1.00f]];
    [aSwitch setOnTintColor:[UIColor colorWithRed:0.91f green:0.30f blue:0.24f alpha:1.00f]];
    [aSwitch setOffTintColor:[UIColor colorWithRed:0.93f green:0.94f blue:0.95f alpha:1.00f]];
    [aSwitch setThumbTintColor:[UIColor yellowColor]];
    
    [self.view addSubview:aSwitch];
}

@end
