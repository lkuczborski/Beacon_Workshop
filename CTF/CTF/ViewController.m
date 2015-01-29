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

#define MAX_HUE 65535
#define HUE_STEP 1000
#define SATURATION_STEP 5

static NSString *const HUE_1 = @"430F6ED4-7E4F-4F63-85C7-845763861A55";
static NSString *const HUE_2 = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
static NSString *const HUE_3 = @"3A7E7514-A9AC-41F3-A236-3CFCE75BAC95";

static NSString *const HUE_1_NAME = @"Hue Lamp";
static NSString *const HUE_2_NAME = @"Hue Lamp 1";
static NSString *const HUE_3_NAME = @"Hue Lamp 2";


@interface ViewController () <BeaconEventHandler>

@property (weak, nonatomic) IBOutlet UIView *currentTeam;

@property (weak, nonatomic) IBOutlet UIView *hue1;
@property (weak, nonatomic) IBOutlet UIView *hue2;
@property (weak, nonatomic) IBOutlet UIView *hue3;

@property (nonatomic, strong) NSDictionary *hueIDToName;
@property (nonatomic, strong) NSDictionary *nameToHueID;

@property (nonatomic, strong) BeaconHandler *handler;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hueIDToName = @{HUE_1:HUE_1_NAME, HUE_2:HUE_2_NAME, HUE_3:HUE_3_NAME};
    self.nameToHueID = @{HUE_1_NAME:HUE_1, HUE_2_NAME:HUE_2, HUE_3_NAME:HUE_3};
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupBeaconHandler];
}

#pragma mark - Team Select Action

- (IBAction)switchTeam:(UIControl *)sender {
    
    self.currentTeam.backgroundColor = sender.backgroundColor;
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
    
    [self updateBulbsIndycators];
}

#pragma mark - UI

- (void)updateBulbsIndycators
{
    
}

#pragma mark - Hue Changes
- (void)changeBulbHueWithBeacon:(Beacon *)beacon
{
    PHLight *lightToChange = [self lightForBeacon:beacon];
    
    if (lightToChange == nil) {
        NSLog(@"%s\t No lihgt bulb to change :(", __PRETTY_FUNCTION__);
        return;
    }
    
    [self updateLight:lightToChange withColor:self.currentTeam.backgroundColor];
}
/*
 * ---------------------- ATTENTION ----------------------
 *
 * Red color is both at 0 and HUE_MAX - thanks to this we can make smooth transitions between our colors.
 * Red(0) -> Green -> Blue -> Red(HUE_MAX)
 * Just have to figure out how :)
 *
 * ---------------------- ATTENTION ----------------------
 */
- (NSInteger)calculateNewHueStepFromLightState:(PHLightState *)lightState toColor:(UIColor *)newColor {
    PHLightState *currentColor = lightState;
    NSInteger currentHue = [[currentColor hue] integerValue];
    NSInteger currentSaturation = [[currentColor saturation] integerValue];
    
    CGFloat hue, saturation;
    [newColor getHue:&hue saturation:&saturation brightness:nil alpha:nil];
    
    NSInteger targetHue = hue * MAX_HUE;
    NSInteger targetSaturation = saturation * 254;
    
    NSInteger newHue = currentHue;
    NSInteger newSaturation = 0;
    
    if (currentHue != targetHue) {
        if (currentHue > targetHue) {
            newHue = currentHue - HUE_STEP;
            if (newHue < targetHue)
                newHue = targetHue;
            if (newHue < 0)
                newHue = 0;
        } else {
            newHue = currentHue + HUE_STEP;
            if (newHue > targetHue)
                newHue = targetHue;
            if (newHue > MAX_HUE)
                newHue = MAX_HUE;
        }
    }
    
    if (currentSaturation != targetSaturation) {
        if (currentSaturation > targetSaturation) {
            newSaturation = currentSaturation - SATURATION_STEP;
            if (newSaturation < targetSaturation)
                newSaturation = targetSaturation;
            if (newSaturation < 0)
                newSaturation = 0;
        } else {
            newSaturation = currentSaturation + SATURATION_STEP;
            if (newSaturation > targetSaturation)
                newSaturation = targetSaturation;
            if (newSaturation > 254) //MAKE MAX_SATURATION
                newSaturation = 254;
        }
    }
    
    return newHue;
}

- (void)updateLight:(PHLight *)light withColor:(UIColor *)newColor {
    
    NSInteger hueToSet = [self calculateNewHueStepFromLightState:light.lightState
                                                         toColor:newColor];
    
    PHLightState *newLightState = [self lightStateForHue:hueToSet];
    
    [self updateLight:light withState:newLightState];
}

- (PHLightState *)lightStateForHue:(NSInteger)hue {
    
    PHLightState *newLightState = [[PHLightState alloc] init];
    [newLightState setHue:@(hue)];
    [newLightState setSaturation:@(254)];
    [newLightState setBrightness:@(0)];
    
    return newLightState;
}

- (void)updateLight:(PHLight *)light withState:(PHLightState *)newState {
    
    PHBridgeSendAPI *sendApi = [[PHBridgeSendAPI alloc] init];
    
    [sendApi updateLightStateForId:light.identifier
                    withLightState:newState
                 completionHandler:^(NSArray *errors) {
                     if (errors != nil) {
                         NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
                         
                         NSLog(@"Response: %@",message);
                     }
                     
                 }];
}

- (PHLight *)lightForBeacon:(Beacon *)beacon {
    
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    
    NSString *beaconID = beacon.uuid;
    NSString *bulbName = self.hueIDToName[beaconID];

    for (PHLight *lightBulb in cache.lights.allValues) {

        if ([lightBulb.name isEqualToString:bulbName]) {
            return lightBulb;
        }
    }
    
    return nil;
}

@end
