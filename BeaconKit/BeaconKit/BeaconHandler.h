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

/**
 *  Called on BeaconHandler delegate when some beacons were updated.
 *
 *  @param handler BeaconHandler instance that updated it's beacons.
 *  @param beacons NSArray of Beacon instances that were updated.
 */
- (void)beaconHandler:(BeaconHandler *)handler
     didUpdateBeacons:(NSArray *)beacons;

@end

/**
 *  Class that encapsulates logic required for beacon magic to work.
 */
@interface BeaconHandler : NSObject

@property (nonatomic, weak) id <BeaconEventHandler> delegate;

/**
 *  Designated initalizer for creating a BeaconManager.
 *
 *  @param regions  NSArray of BeaconRegion instancess defining regions in whitch this manager should handle beacons.
 *  @param delegate Delegate that will be notified about updated beacons.
 *
 *  @return Instance of BeaconHandler.
 */
- (instancetype)initWithBeaconRegions:(NSArray *)regions
                             delegate:(id <BeaconEventHandler>)delegate NS_DESIGNATED_INITIALIZER;

/**
 *  Starts monitoring for beacons in defined regions.
 */
- (void)start;

@end
