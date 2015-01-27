//
//  ViewController.m
//  CTF
//
//  Created by Lukasz Kuczborski on 21.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import "ViewController.h"

#import <BeaconKit/BeaconKit.h>
#import <HueSDK_iOS/HueSDK.h>

static NSString *const HUE_1 = @"430F6ED4-7E4F-4F63-85C7-845763861A55";
static NSString *const HUE_2 = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
static NSString *const HUE_3 = @"3A7E7514-A9AC-41F3-A236-3CFCE75BAC95";

@interface ViewController () <BeaconEventHandler>

@property (weak, nonatomic) IBOutlet UIView *currentTeam;

@property (weak, nonatomic) IBOutlet UIView *hue1;
@property (weak, nonatomic) IBOutlet UIView *hue2;
@property (weak, nonatomic) IBOutlet UIView *hue3;

@property (nonatomic, strong) BeaconHandler *handler;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupBeaconHandler];
}


#pragma mark - Team Select Action

- (IBAction)switchTeam:(UIControl *)sender {
    
    self.currentTeam.backgroundColor = sender.backgroundColor;
}

#pragma mark - Hue Changes
- (void)changeBulbHueWithBeacon:(Beacon *)beacon
{
    
}

#pragma mark - BeaconHandler

- (void)setupBeaconHandler {
    NSArray *regions = @[
                         [[BeaconRegion alloc] initWithUUID:HUE_1
                                                       name:@"Estimote Mint Cocktail"],
                         [[BeaconRegion alloc] initWithUUID:HUE_2
                                                       name:@"Estimote Icy Marshmallow"],
                         [[BeaconRegion alloc] initWithUUID:HUE_3
                                                       name:@"Estimote Blueberry Pie"]
                         ];
    
    self.handler = [[BeaconHandler alloc] initWithBeaconRegions:regions
                                                       delegate:self];
    
    [self.handler start];
}


#pragma mark - BeaconEventHandler
- (void)beaconHandler:(BeaconHandler *)handler
     didUpdateBeacons:(NSArray *)beacons {
    
    for (Beacon *beacon in beacons) {
        if (beacon.proximity == CLProximityImmediate) {
            [self changeBulbHueWithBeacon:beacon];
        }
    }
}

@end
