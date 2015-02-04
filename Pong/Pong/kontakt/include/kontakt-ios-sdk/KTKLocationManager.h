//
//  KTKLocationManager.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 17/03/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

@class KTKLocationManager;
@class KTKRegion;

/**
 Possible states of KTKLocationManager object.
 */
typedef NS_ENUM(int, KTKLocationManagerState) {
    /**
     Location manager is not monitoring beacons.
     */
    KTKLocationManagerStateInactive,
    
    /**
     Location manager is preparing to monitro beacons.
     */
    KTKLocationManagerStateInitializing,
    
    /**
     Location manager is monitoring beacons.
     */
    KTKLocationManagerStateMonitoring,
    
    /**
     Location manager did fail to monitor beacons.
     */
    KTKLocationManagerStateFailed,
};

/**
 Responds to location manager events. Methods are called from the thread in which you started the corresponding location manager. This thread must have its own run loop.
 */
@protocol KTKLocationManagerDelegate <NSObject>

/**
 Informs that location manager changed its state.
 
 @param locationManager location manager reporting the event
 @param state state of corresponding location manager
 @param error error if state is KTKLocationManagerStateFailed
 */
- (void)locationManager:(KTKLocationManager *)locationManager didChangeState:(KTKLocationManagerState)state withError:(NSError *)error;

/**
 Informs that location manager has entered region. This happens when device encounters beacon that belongs to a set of beacons defined by region. Notification will only happen once per region until it is exited and entered again.
 
 @param locationManager location manager reporting the event
 @param region entered region
 */
- (void)locationManager:(KTKLocationManager *)locationManager didEnterRegion:(KTKRegion *)region;

/**
 Informs that location manager has exited region. This happens when device has no beacon in range that belongs to a set of beacons defined by region. Notification will only happen once per region until it is entered and exited again.
 
 @param locationManager location manager reporting the event
 @param region exited region
 */
- (void)locationManager:(KTKLocationManager *)locationManager didExitRegion:(KTKRegion *)region;

/**
 Informs that location manager has ranged nearby beacons.
 
 @param locationManager location manager reporting the event
 @param beacons array of CLBeacon objects
 */
- (void)locationManager:(KTKLocationManager *)locationManager didRangeBeacons:(NSArray *)beacons;

@end

/**
 Is responsible for monitoring nearby beacons.
 */
@interface KTKLocationManager : NSObject

#pragma mark - class methods

/**
 Boleaon value indicating if device is capable of monitoring beacons.
 */
+ (BOOL)canMonitorBeacons;

#pragma mark - properties

/**
 Responses to location manager events.
 */
@property (weak, nonatomic, readwrite) id<KTKLocationManagerDelegate> delegate;

/**
 Location manager state.
 */
@property (assign, nonatomic, readonly) KTKLocationManagerState state;

#pragma mark - public methods

/**
 Sets regions for which beacons are monitored. You have to invoke startMonitoringBeacons every time you set new regions to monitor beacons.
 
 @param regions array of object that conforms to KTKRegion protocol.
 */
- (void)setRegions:(NSArray *)regions;

/**
 Tells location manager to start monitoring beacons.
 */
- (void)startMonitoringBeacons;

/**
 Tells location manager to stop monitoring beacons.
 */
- (void)stopMonitoringBeacons;

@end
