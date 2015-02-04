//
//  KTKActionManager.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 14/03/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#include "KTKAction.h"

@class KTKActionManager;
@class KTKBeacon;

/**
 Responds to action manager events. Methods are called on the main thread.
 */
@protocol KTKActionManagerDelegate <NSObject>

@optional

/**
 Tells delegate object that corresponding action manager did determine action.
 
 @param actionManager action manager reporting the event
 @param action determined action
 */
- (void)actionManager:(KTKActionManager *)actionManager didDetermineAction:(id<KTKAction>)action;

@end

/**
 Is responsible for determining actions to execute.
 */
@interface KTKActionManager : NSObject

#pragma mark - properties

/**
 Delay in seconds. Value of this property indicates how fast action manager will react to location changes. Low delay may cause action manager to react to some bad location measurements that can happen randomly. Recommended value is between 1 and 5.
 */
@property (assign, nonatomic, readwrite) NSTimeInterval delay;

/**
 Responds to action manager events.
 */
@property (weak, nonatomic, readwrite) id<KTKActionManagerDelegate> delegate;

#pragma mark - public methods

/**
 Tells action manager to process beacons and data assigned to them. Beacons are processed to determine action that should be executed based on beacons location.
 
 @param beacons array of CLBeacon objects - it can be obtained from locationManager:didRangeBeacons: method of KTKLocationManagerDelegate
 @param data dictionary where keys are CLBeacon objects and values are corresponding data objects that conforms to KTKBeacon protocol
 */
- (void)processBeacons:(NSArray *)beacons withData:(NSDictionary *)data;

@end
