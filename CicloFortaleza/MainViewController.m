//
//  MainViewController.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 02/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

-(void) awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"]];
//    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"MKMapViewController"]];
    

//    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"]];
//    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"]];
}


@end
