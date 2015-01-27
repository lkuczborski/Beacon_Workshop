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

@interface ViewController () <BeaconEventHandler>

@property (weak, nonatomic) IBOutlet UIView *currentTeam;

@property (weak, nonatomic) IBOutlet UIView *hue1;
@property (weak, nonatomic) IBOutlet UIView *hue2;
@property (weak, nonatomic) IBOutlet UIView *hue3;

@property (nonatomic, strong) NSMutableDictionary *beaconToBulbPairing;

@property (nonatomic, strong) BeaconHandler *handler;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _beaconToBulbPairing = [NSMutableDictionary dictionary];
    
    [self setupBeaconHandler];
}

- (void)pairBulbsWithBeacons {
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    
    for (PHLight *light in cache.lights.allValues) {
        [self.beaconToBulbPairing setObject:light.identifier forKey:HUE_1];
    }
}

#pragma mark - Team Select Action

- (IBAction)switchTeam:(UIControl *)sender {
    
    self.currentTeam.backgroundColor = sender.backgroundColor;
    [self stepBulb:self.beaconToBulbPairing[HUE_1] toColor:sender.backgroundColor];
    
//    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
//    PHBridgeSendAPI *bridgeSendAPI = [[PHBridgeSendAPI alloc] init];
//    
//    CGFloat hue, saturation;
//    [sender.backgroundColor getHue:&hue saturation:&saturation brightness:nil alpha:nil];
//    
//    for (PHLight *light in cache.lights.allValues) {
//        
//        PHLightState *lightState = [[PHLightState alloc] init];
//        
//        
//        [lightState setHue:@(hue * MAX_HUE)];
//        [lightState setBrightness:[NSNumber numberWithInt:0]];
//        [lightState setSaturation:@(saturation * 254)];
//        
//        // Send lightstate to light
//        [bridgeSendAPI updateLightStateForId:light.identifier withLightState:lightState completionHandler:^(NSArray *errors) {
//            if (errors != nil) {
//                NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
//                
//                NSLog(@"Response: %@",message);
//            }
//            
//        }];
//    }
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

- (void)stepBulb:(NSString*)light toColor:(UIColor*)color {
    
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    
    for (PHLight *lightBulb in cache.lights.allValues) {
        PHLightState *currentColor = lightBulb.lightState;
        NSInteger currentHue = [[currentColor hue] integerValue];
        NSInteger currentSaturation = [[currentColor saturation] integerValue];
        
        CGFloat hue, saturation;
        [color getHue:&hue saturation:&saturation brightness:nil alpha:nil];
        
        NSInteger targetHue = hue * MAX_HUE;
        NSInteger targetSaturation = saturation * 254;
        
        NSInteger newHue = currentHue;
        NSInteger newSaturation = 0;
        
        PHLightState *newLightState = [[PHLightState alloc] init];
        
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
        
        NSLog(@"sending to Light %@ : currentHue -> %i; targetHue -> %i; newHue -> %i;", lightBulb.identifier, currentHue, targetHue, newHue);
        
        [newLightState setHue:@(newHue)];
        [newLightState setSaturation:@(254)];
        [newLightState setBrightness:@(0)];
        
        PHBridgeSendAPI *sendApi = [[PHBridgeSendAPI alloc] init];
        [sendApi updateLightStateForId:lightBulb.identifier withLightState:newLightState completionHandler:^(NSArray *errors) {
            if (errors != nil) {
                NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
                
                NSLog(@"Response: %@",message);
            }
            
        }];
    }
    
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
