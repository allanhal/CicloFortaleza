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
@synthesize lineView;
@synthesize bottomView;
@synthesize tableSizeButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self mountNavBar];
}

- (void)mountNavBar
{
    [self mountTopView];

    [self mountTopLabel];
    [self mountTopTextField];
    [self mountSearchButton];
    [self mountLineView];
    [self mountBottomView];
    [self mountMenuButton];
    [self mountUserLocationButton];
    [self mountTableSize];
}

- (void)mountTopView
{
    topView = [[UIImageView alloc] initWithImage:[ImagesUtil topo]];
    [self.view addSubview:topView];
}

- (void)mountTopLabel
{
    CGFloat x = 110;
    CGFloat y = 25;
    CGFloat width = 100;
    CGFloat height = 20;
    
    topLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    topLabel.text = @"CALANGA";
    topLabel.textColor = [UIColor whiteColor];
    UIFont *labelFont = [UIFont boldSystemFontOfSize:20];
    topLabel.font = labelFont;
    
    [self.view addSubview:topLabel];
}

- (void)mountTopTextField
{
    UIImage *buscaImage = [ImagesUtil busca];
    
    CGFloat x = self.defaultPadding;
    CGFloat y = 25;
    CGFloat width = self.mainScreen.size.width - buscaImage.size.width - self.defaultPadding - self.defaultPadding;
    CGFloat height = 20;
    
    topTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
    topTextField.placeholder = @"Buscar...";
    UIColor *color = [UIColor whiteColor];
    topTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:topTextField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    topTextField.textColor = [UIColor whiteColor];
    topTextField.hidden = YES;
    
    [self.view addSubview:topTextField];
}

- (void)mountSearchButton
{
    UIImage *buscaImage = [ImagesUtil busca];
    CGFloat x = self.mainScreen.size.width - buscaImage.size.width - self.defaultPadding;
    CGFloat y = 15;
    CGFloat width = buscaImage.size.width;
    CGFloat height = buscaImage.size.height;
    
    self.searchButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [self.searchButton setImage:buscaImage forState:UIControlStateNormal];
    
    [self.searchButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
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
    
    [self.view addSubview:self.searchButton];
}

- (void)mountLineView
{
    UIImage *img = [ImagesUtil linha];
    lineView = [[UIImageView alloc] initWithImage:img];
    lineView.frame = CGRectMake((self.mainScreen.size.width/2) - (img.size.width/2),
                                60,
                                img.size.width,
                                img.size.height);
    [self.view addSubview:lineView];
}

- (void)mountBottomView
{
    UIImage *menuInferiorImage = [ImagesUtil menuInferior];
    CGFloat x = 0;
    CGFloat y = (self.mainScreen.size.height - menuInferiorImage.size.height);
    CGFloat width = menuInferiorImage.size.width;
    CGFloat height = menuInferiorImage.size.height;
    
    bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [bottomView setImage:menuInferiorImage];

    [self.view addSubview:bottomView];
}

- (void)mountMenuButton
{
    UIImage *menuImage = [ImagesUtil menu];
    CGFloat x = self.defaultPadding;
    CGFloat y = (self.mainScreen.size.height - menuImage.size.height);
    CGFloat width = menuImage.size.width;
    CGFloat height = menuImage.size.height;
    
    menuButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    
    [menuButton setImage:menuImage forState:UIControlStateNormal];
    [menuButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        [self.sidePanelController showLeftPanelAnimated:YES];
    }];
    
    [self.view addSubview:menuButton];
}

- (void)mountUserLocationButton
{
    UIImage *setaVazada = [ImagesUtil setaVazada];
    UIImage *seta = [ImagesUtil seta];
    
    CGFloat x = self.mainScreen.size.width/2 - seta.size.width/2;
    CGFloat y = (self.mainScreen.size.height - seta.size.height);
    CGFloat width = seta.size.width;
    CGFloat height = seta.size.height;
    
    self.userLocationButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [self.userLocationButton setImage:seta forState:UIControlStateNormal];
    
    [self.userLocationButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        if(self.mapView.userTrackingMode == RMUserTrackingModeFollow)
        {
            [self.userLocationButton setImage:setaVazada forState:UIControlStateNormal];
            [self changeToFollow:NO];
        }
        else
        {
            [self.userLocationButton setImage:seta forState:UIControlStateNormal];
            [self changeToFollow:YES];
        }
        [self moveMapToUserLocation];
    }];
    
    [self.view addSubview:self.userLocationButton];
}

- (void)mountTableSize
{
    UIImage *cima = [ImagesUtil cima];
    UIImage *baixo = [ImagesUtil baixo];
    
    UIImage *cimacima = [ImagesUtil cimacima];
    
    CGFloat x = self.mainScreen.size.width - cimacima.size.width - self.defaultPadding;
    CGFloat y = (self.mainScreen.size.height - cimacima.size.height);
    CGFloat width = cima.size.width;
    CGFloat height = cima.size.height;
    
    self.tableSizeButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [self.tableSizeButton setImage:cimacima forState:UIControlStateNormal];
    
    [self.tableSizeButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        if([Manager tableManager].tablePosition == TablePositionNone)
        {
            [Manager tableManager].tablePosition = TablePositionBottom;
            [self changeToDefaultTablePosition];
            [self.tableSizeButton setImage:cimacima forState:UIControlStateNormal];
        }
        else if([Manager tableManager].tablePosition == TablePositionBottom)
        {
            [Manager tableManager].tablePosition = TablePositionFull;
            [self changeToDefaultTablePosition];
            [self.tableSizeButton setImage:baixo forState:UIControlStateNormal];
        }
        else if([Manager tableManager].tablePosition == TablePositionFull)
        {
            [Manager tableManager].tablePosition = TablePositionNone;
            [self changeToDefaultTablePosition];
            [self.tableSizeButton setImage:cima forState:UIControlStateNormal];
        }
    }];
    
    [self.view addSubview:self.tableSizeButton];
}

@end
