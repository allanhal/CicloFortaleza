//
//  LeftViewController.m
//  CicloFortaleza
//
//  Created by Allan Araujo on 02/05/14.
//  Copyright (c) 2014 Allan Araujo. All rights reserved.
//

#import "LeftViewController.h"
#import "MBSwitch.h"
#import "ColorUtil.h"

@implementation LeftViewController

@synthesize topLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [ColorUtil r:14 g:46 b:51];
    
    [self mountTopic:@"Categoria 1" withPosition:1];

    [self mountOption:@"Opcão 1" withPosition:2 withSwitch:[NSNumber numberWithInt:0]];
    
//    [self mountOption:@"Opção 2" withPosition:3 withSwitch:[NSNumber numberWithInt:0]];
    
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
    aSwitch.offTintColor = [ColorUtil r:14 g:46 b:51];
    aSwitch.thumbTintColor = [ColorUtil r:102 g:153 b:153];
    aSwitch.onTintColor = [ColorUtil r:70 g:114 b:116];
    aSwitch.tintColor = [ColorUtil r:102 g:153 b:153];
    aSwitch.on = on;
    
    [self.view addSubview:aSwitch];
}

@end
