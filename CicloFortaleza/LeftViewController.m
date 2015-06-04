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
#import "ALActionBlocks.h"
#import "UIViewController+JASidePanel.h"
#import "CenterViewController.h"
#import "MainViewController.h"

@implementation LeftViewController

@synthesize topLabel;
@synthesize positionPadding;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [ColorUtil r:14 g:46 b:51];
    
    self.positionPadding = 30;
    
    UIImage *logoImage = [UIImage imageNamed:@"logo"];
    
    CGFloat width = logoImage.size.width/10;
    CGFloat height = logoImage.size.height/10;


    CGFloat x = 0;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height/2) - (height/2);
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    imageView.image = logoImage;
    [self.view addSubview:imageView];
    /*
    
    [self mountTopic:@"Busca" withPosition:1];
    
    [self mountOption:@"Filtro 1" withPosition:2 withSwitch:[NSNumber numberWithInt:0]];
    [self mountOption:@"Filtro 2" withPosition:3 withSwitch:[NSNumber numberWithInt:1]];
    [self mountOption:@"Filtro 3" withPosition:4 withSwitch:[NSNumber numberWithInt:0]];
    [self mountOption:@"Filtro 4" withPosition:5 withSwitch:[NSNumber numberWithInt:0]];
    
    [self mountTopic:@"Mapas" withPosition:6];
    
    [self mountOption:@"Golbery" withPosition:7 action:^{
    }];

    [self mountOption:@"Felipe Alves" withPosition:8 action:^{
    }];
     */
}

- (void)mountTopic:(NSString *)text withPosition:(int)position
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, position*positionPadding, 100, 20)];
    label.text = text;
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor redColor];
    
    [self.view addSubview:label];
}

- (void)mountOption:(NSString *)text withPosition:(int)position
{
    [self mountOption:text withPosition:position withSwitch:nil];
}

- (void)mountOption:(NSString *)text withPosition:(int)position action:(void (^)(void))action
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40, position*positionPadding, 200, 20)];
    button.titleLabel.text = text;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    button.backgroundColor = [UIColor blueColor];
    
    [button setTitle:text forState:UIControlStateNormal];
    
    [button handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        if(action){
            action();
        }
    }];
    
    [self.view addSubview:button];
}

- (void)mountOption:(NSString *)text withPosition:(int)position withSwitch:(NSNumber *)switchOn
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, position*positionPadding, 100, 20)];
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
    MBSwitch *aSwitch = [[MBSwitch alloc] initWithFrame:CGRectMake(185, position*positionPadding, 35, 20)];
    aSwitch.offTintColor = [ColorUtil r:14 g:46 b:51];
    aSwitch.thumbTintColor = [ColorUtil r:102 g:153 b:153];
    aSwitch.onTintColor = [ColorUtil r:70 g:114 b:116];
    aSwitch.tintColor = [ColorUtil r:102 g:153 b:153];
    aSwitch.on = on;
    
    [self.view addSubview:aSwitch];
}

@end
