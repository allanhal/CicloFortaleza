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
@synthesize menuButton;
@synthesize topLabel;
@synthesize topTextField;
@synthesize searchButton;
@synthesize userLocationButton;
@synthesize lineView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self mountNavBar];
}

- (void)mountNavBar
{
    [self mountTopView];
    [self mountMenuButton];
    [self mountTopLabel];
    [self mountTopTextField];
    [self mountSearchButton];
    [self mountUserLocationButton];
    [self mountLineView];
}

- (void)mountTopView
{
    topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topo"]];
    [self.view addSubview:topView];
}

- (void)mountMenuButton
{
    userLocationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 65, 30)];
    
    [userLocationButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [userLocationButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        [self.sidePanelController showLeftPanelAnimated:YES];
    }];
    
    [self.view addSubview:userLocationButton];
}

- (void)mountTopLabel
{
    topLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 25, 100, 20)];
    topLabel.text = @"CALANGA";
    topLabel.textColor = [UIColor whiteColor];
    UIFont *labelFont = [UIFont boldSystemFontOfSize:20];
    topLabel.font = labelFont;
    
    [self.view addSubview:topLabel];
}

- (void)mountTopTextField
{
    topTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 25, 180, 20)];
    topTextField.placeholder = @"Buscar...";
    UIColor *color = [UIColor whiteColor];
    topTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:topTextField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    topTextField.textColor = [UIColor whiteColor];
    topTextField.hidden = YES;
    
    [self.view addSubview:topTextField];
}

- (void)mountSearchButton
{
    userLocationButton = [[UIButton alloc] initWithFrame:CGRectMake(230, 22, 65, 30)];
    [userLocationButton setImage:[UIImage imageNamed:@"busca"] forState:UIControlStateNormal];
    
    [userLocationButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        self.topLabel.hidden = !self.topLabel.hidden;
        self.topTextField.hidden = !self.topTextField.hidden;
    }];
    
    [self.view addSubview:userLocationButton];
}

- (void)mountUserLocationButton
{
    userLocationButton = [[UIButton alloc] initWithFrame:CGRectMake(265, 22, 65, 30)];
    [userLocationButton setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    
    [userLocationButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        self.mapView.centerCoordinate = self.mapView.userLocation.coordinate;
        [self.mapView moveBy:CGSizeMake(0, 100)];
    }];
    
    [self.view addSubview:userLocationButton];
}

- (void)mountLineView
{
    UIImage *img = [UIImage imageNamed:@"linha01"];
    lineView = [[UIImageView alloc] initWithImage:img];
    lineView.frame = CGRectMake((self.view.frame.size.width/2) - (img.size.width/2),
                                60,
                                img.size.width,
                                img.size.height);
    [self.view addSubview:lineView];
}

@end
