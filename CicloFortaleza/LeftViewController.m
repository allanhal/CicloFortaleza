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
    
    [self mountTopic:@"Categoria 1" withPosition:1];

    [self mountOption:@"Opcão 1" withPosition:2 withSwitch:[NSNumber numberWithInt:1]];
    
    [self mountOption:@"Opção 2" withPosition:3 withSwitch:[NSNumber numberWithInt:0]];
    
    [self mountTopic:@"Categoria 4" withPosition:4];
    
    [self mountOption:@"Opcão 1" withPosition:5];
    
    [self mountOption:@"Opção 2" withPosition:6];

}

- (void)mountTopic:(NSString *)text withPosition:(int)position
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, position*50, 100, 20)];
    label.text = text;
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor redColor];
    
    [self.view addSubview:label];
}

- (void)mountOption:(NSString *)text withPosition:(int)position
{
    [self mountOption:text withPosition:position withSwitch:nil];
}

- (void)mountOption:(NSString *)text withPosition:(int)position withSwitch:(NSNumber *)switchOn
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, position*50, 100, 20)];
    label.text = text;
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor redColor];
    
    [self.view addSubview:label];
    
    if(switchOn)
    {
        [self mountBoolWithPosition:position On:[switchOn boolValue]];
    }
}

- (void)mountBoolWithPosition:(int)position On:(BOOL)on
{
    MBSwitch *aSwitch = [[MBSwitch alloc] initWithFrame:CGRectMake(185, position*50, 50, 20)];
//    aSwitch.tintColor = [UIColor colorWithRed:0.58f green:0.65f blue:0.65f alpha:1.00f];
//    aSwitch.onTintColor = [UIColor colorWithRed:0.91f green:0.30f blue:0.24f alpha:1.00f];
//    aSwitch.offTintColor = [UIColor colorWithRed:0.93f green:0.94f blue:0.95f alpha:1.00f];
//    aSwitch.thumbTintColor = [UIColor yellowColor];
    aSwitch.tintColor = [UIColor greenColor];
    aSwitch.onTintColor = [UIColor greenColor];
    aSwitch.offTintColor = [UIColor whiteColor];
    aSwitch.thumbTintColor = [UIColor whiteColor];
    aSwitch.on = on;
    
    [self.view addSubview:aSwitch];
}

- (CGRect)frameWithPosition:(int)position
{
    return CGRectMake(40, position*50, 100, 20);
}

@end
