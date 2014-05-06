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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [ColorUtil r:14 g:46 b:51];
    
    [self mountTopic:@"Categoria 1" withPosition:1];

    [self mountOption:@"Opcão 1" withPosition:2 withSwitch:[NSNumber numberWithInt:0]];
    
    [self mountTopic:@"Categoria 3" withPosition:3];
    
    [self mountOption:@"Completo" withPosition:4 action:^{
        MainViewController *main = (MainViewController *)self.sidePanelController;
        CenterViewController *centerViewController = (CenterViewController *)main.centerPanel;
        
        [Manager tableManager].tablePosition = TablePositionFull;
        [centerViewController changeToDefaultTablePosition];
    }];
    
    [self mountOption:@"Compacto" withPosition:5 action:^{
        MainViewController *main = (MainViewController *)self.sidePanelController;
        CenterViewController *centerViewController = (CenterViewController *)main.centerPanel;
        
        [Manager tableManager].tablePosition = TablePositionBottom;
        [centerViewController changeToDefaultTablePosition];
    }];
    
    [self mountOption:@"Topo" withPosition:6 action:^{
        MainViewController *main = (MainViewController *)self.sidePanelController;
        CenterViewController *centerViewController = (CenterViewController *)main.centerPanel;
        
        [Manager tableManager].tablePosition = TablePositionTop;
        [centerViewController changeToDefaultTablePosition];
    }];
    
    [self mountOption:@"Nenhum" withPosition:7 action:^{
        MainViewController *main = (MainViewController *)self.sidePanelController;
        CenterViewController *centerViewController = (CenterViewController *)main.centerPanel;
        
        [Manager tableManager].tablePosition = TablePositionNone;
        [centerViewController changeToDefaultTablePosition];
    }];
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

- (void)mountOption:(NSString *)text withPosition:(int)position action:(void (^)(void))action
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40, position*50, 100, 20)];
    button.titleLabel.text = text;
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
    MBSwitch *aSwitch = [[MBSwitch alloc] initWithFrame:CGRectMake(185, position*50, 35, 20)];
    aSwitch.offTintColor = [ColorUtil r:14 g:46 b:51];
    aSwitch.thumbTintColor = [ColorUtil r:102 g:153 b:153];
    aSwitch.onTintColor = [ColorUtil r:70 g:114 b:116];
    aSwitch.tintColor = [ColorUtil r:102 g:153 b:153];
    aSwitch.on = on;
    
    [self.view addSubview:aSwitch];
}

@end
