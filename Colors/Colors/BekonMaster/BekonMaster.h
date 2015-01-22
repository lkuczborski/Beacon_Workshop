//
//  BeaconMaster.h
//  Colors
//
//  Created by Lukasz Stocki on 22.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

@import Foundation;
@import CoreLocation;

#import "BeaconInformation.h"
#import "BeaconRegion.h"

@class BeaconMaster;

@protocol BeaconEventHandler <NSObject>

- (void)BeaconMaster:(BeaconMaster *)maseter didUpdateBakons:(NSArray *)bakons;

@end

@interface BeaconMaster : NSObject

- (instancetype)initWithBeaconRegions:(NSArray *)regions
                            delegate:(id<BeaconEventHandler>)delegate NS_DESIGNATED_INITIALIZER;

- (NSArray *)farBacons;
- (NSArray *)nearBacons;
- (NSArray *)immediateBacons;

@end
