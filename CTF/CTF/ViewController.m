//
//  ViewController.m
//  CTF
//
//  Created by Lukasz Kuczborski on 21.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *currentTeam;

@property (weak, nonatomic) IBOutlet UIView *hue1;
@property (weak, nonatomic) IBOutlet UIView *hue2;
@property (weak, nonatomic) IBOutlet UIView *hue3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - Team Select Action

- (IBAction)switchTeam:(UIControl *)sender {
    
    self.currentTeam.backgroundColor = sender.backgroundColor;
}
@end
