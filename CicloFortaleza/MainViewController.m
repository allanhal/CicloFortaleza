//
//  MainViewController.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 02/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
     UIViewController *leftController = [[UIViewController alloc] init];
     [leftController.view addSubview:self.mapView];
     [self setLeftDrawerViewController:leftController];
     
     UIViewController *centerController = [[UIViewController alloc] init];
     [centerController.view setBackgroundColor:[UIColor whiteColor]];
     [self setCenterViewController:centerController];
     */
    
//    self.viewController = [[JASidePanelController alloc] init];
//    self.viewController.shouldDelegateAutorotateToVisiblePanel = NO;
//    
//	self.viewController.leftPanel = [[JALeftViewController alloc] init];
//	self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[JACenterViewController alloc] init]];
//	self.viewController.rightPanel = [[JARightViewController alloc] init];
}

-(void) awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"]];
}


@end
