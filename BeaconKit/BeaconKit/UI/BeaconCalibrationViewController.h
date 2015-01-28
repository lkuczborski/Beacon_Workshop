//
//  BeaconCalibrationViewController.h
//  BeaconKit
//
//  Created by Lukasz Stocki on 28.01.2015.
//  Copyright (c) 2015 Allegro Group. All rights reserved.
//

@import UIKit;

#import "Beacon.h"
#import "BeaconHandler.h"

@protocol BeaconProvider <NSObject>

/**
 *  Method for getting beacon that should be calibrated.
 *
 *  @return NSArray of Beacon objects.
 */
- (NSArray *)beaconsToCalibrate;

@end

@interface BeaconCalibrationViewController : UIViewController <BeaconEventHandler>

@property (nonatomic, weak) id <BeaconProvider> beaconProvider;
@property (nonatomic, weak) BeaconHandler *beaconHandler;

@end
