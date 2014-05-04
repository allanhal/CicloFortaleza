//
//  CenterViewController.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 02/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "CenterViewController.h"
#import "ALActionBlocks.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"

@implementation CenterViewController

@synthesize topView;
@synthesize topLabel;
@synthesize userLocationButton;
@synthesize menuButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self mountNavBar];
}

- (void)mountNavBar
{
    [self mountTopView];
    [self mountTopLabel];
    [self mountUserLocationButton];
    [self mountMenuButton];
}

- (void)mountTopView
{
    topView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 300, 60)];
    topView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:topView];
}

- (void)mountTopLabel
{
    topLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, 100, 20)];
    topLabel.text = @"Calanga";
    topLabel.backgroundColor = [UIColor grayColor];
    topLabel.textColor = [UIColor redColor];
    
    [topView addSubview:topLabel];
}

- (void)mountUserLocationButton
{
    userLocationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userLocationButton.frame = CGRectMake(230, 5, 65, 30);
    [userLocationButton setTitle:@"User" forState:UIControlStateNormal];
    userLocationButton.backgroundColor = [UIColor greenColor];
    
    [userLocationButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        self.mapView.centerCoordinate = self.mapView.userLocation.coordinate;
        [self.mapView moveBy:CGSizeMake(0, 100)];
    }];
    
    [topView addSubview:userLocationButton];
}

- (void)mountMenuButton
{
    userLocationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userLocationButton.frame = CGRectMake(0, 20, 65, 30);
    [userLocationButton setTitle:@"Menu" forState:UIControlStateNormal];
    userLocationButton.backgroundColor = [UIColor greenColor];
    
    [userLocationButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        [self.sidePanelController showLeftPanelAnimated:YES];
    }];
    
    [topView addSubview:userLocationButton];
}

@end
