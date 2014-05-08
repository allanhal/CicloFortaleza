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
@synthesize bottomView;

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
    [self mountLineView];
    [self mountBottomView];
    [self mountUserLocationButton];
}

- (void)mountTopView
{
    topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topo"]];
    [self.view addSubview:topView];
}

- (void)mountMenuButton
{
    menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 65, 30)];
    
    [menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        [self.sidePanelController showLeftPanelAnimated:YES];
    }];
    
    [self.view addSubview:menuButton];
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
        
        if(self.topTextField.hidden)
        {
            [self changeToDefaultTablePosition];
            [self.topTextField resignFirstResponder];
            self.topTextField.text = @"";
        }
        else
        {
            [self changeTablePosition:TablePositionTop];
            [self.topTextField becomeFirstResponder];
        }
    }];
    
    [self.view addSubview:userLocationButton];
}

- (void)mountLineView
{
    UIImage *img = [UIImage imageNamed:@"linha01"];
    lineView = [[UIImageView alloc] initWithImage:img];
    lineView.frame = CGRectMake((self.mainScreen.size.width/2) - (img.size.width/2),
                                60,
                                img.size.width,
                                img.size.height);
    [self.view addSubview:lineView];
}

- (void)mountBottomView
{
    bottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"base"]];
    CGRect mainScreen = [[UIScreen mainScreen] bounds];
    
    bottomView.frame = CGRectMake(0, (mainScreen.size.height - bottomView.frame.size.height), bottomView.frame.size.width, bottomView.frame.size.height);
    [self.view addSubview:bottomView];
}

- (void)mountUserLocationButton
{
    UIImage *locationImage = [UIImage imageNamed:@"location"];
    
    CGFloat x = self.defaultPadding;
    CGFloat y = (self.mainScreen.size.height - locationImage.size.height - self.defaultPadding);
    CGFloat width = locationImage.size.width;
    CGFloat height = locationImage.size.height;
    
    userLocationButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [userLocationButton setImage:locationImage forState:UIControlStateNormal];
    
    [userLocationButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        if(self.mapView.userTrackingMode == RMUserTrackingModeFollow)
        {
            self.mapView.userTrackingMode = RMUserTrackingModeNone;
        }
        else
        {
            self.mapView.userTrackingMode = RMUserTrackingModeFollow;
            [self moveMapToCorrectPlace];
        }
    }];
    
    [self.view addSubview:userLocationButton];
}


@end
