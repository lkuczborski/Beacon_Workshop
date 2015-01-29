//
//  BeaconHandler.h
//  Colors
//
//  Created by Lukasz Stocki on 22.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

@import Foundation;
@import CoreLocation;
@import UIKit;

#import "Beacon.h"
#import "BeaconRegion.h"

@class BeaconHandler;

@protocol BeaconEventHandler <NSObject>

- (void)beaconHandler:(BeaconHandler *)handler
     didUpdateBeacons:(NSArray *)beacons;

@end

@interface BeaconHandler : NSObject

@property (nonatomic, weak) id <BeaconEventHandler> delegate;

- (instancetype)initWithBeaconRegions:(NSArray *)regions
                             delegate:(id <BeaconEventHandler>)delegate NS_DESIGNATED_INITIALIZER;

- (void)start;

@end
