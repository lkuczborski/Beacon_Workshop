//
//  BeaconCalibrationViewController.m
//  BeaconKit
//
//  Created by Lukasz Stocki on 28.01.2015.
//  Copyright (c) 2015 Allegro Group. All rights reserved.
//

#import "BeaconCalibrationViewController.h"

@interface BeaconCalibrationViewController ()

@end

@implementation BeaconCalibrationViewController


- (IBAction)userDidTapButtonHide:(UIButton *)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}

@end
