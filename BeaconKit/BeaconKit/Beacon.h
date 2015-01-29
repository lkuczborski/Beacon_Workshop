//
//  Beacon.h
//  Colors
//
//  Created by Lukasz Stocki on 22.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

@import Foundation;
@import CoreLocation;

/**
 *  Class representing a beacon.
 */
@interface Beacon : NSObject


@property (nonatomic, readonly) NSString *uuid;

@property (nonatomic, strong) NSNumber *major;
@property (nonatomic, strong) NSNumber *minor;

@property (assign, nonatomic) CLProximity proximity;

@property (assign, readwrite, nonatomic) CLLocationAccuracy accuracy;

/**
 *  Closest that the beacon ever was.
 */
@property (assign, readonly, nonatomic) CLLocationAccuracy accuracyMax;

/**
 *  Farthest that the beacon ever was.
 */
@property (assign, readonly, nonatomic) CLLocationAccuracy accuracyMin;

@property (assign, nonatomic) NSInteger rssi;

/**
 *  Strongest that the RSSI ever was.
 */
@property (assign, readonly, nonatomic) NSInteger rssiMax;

/**
 *  Weakest that the RSSI ever was.
 */
@property (assign, readonly, nonatomic) NSInteger rssiMin;

/**
 *  If not nil it will be used for accuracyMax.
 */
@property (nonatomic, strong) NSNumber *customAccuracyMax;

/**
 *  If not nil it will be used for accuracyMin.
 */
@property (nonatomic, strong) NSNumber *customAccuracyMin;

/**
 *  If not nil it will be used for rssiMax.
 */
@property (nonatomic, strong) NSNumber *customRSSIMax;

/**
 *  If not nil it will be used for rssMin.
 */
@property (nonatomic, strong) NSNumber *customRSSIMin;

/**
 *  Designated initializer for creating a new Beacon instance.
 *
 *  @param uuid  UUID for the beacon.
 *  @param major Major value for the beacon.
 *  @param minor Minor value for the beacon.
 *
 *  @return New instance of Beacon.
 */
- (instancetype)initWithUUID:(NSString *)uuid
                       major:(NSNumber *)major
                       minor:(NSNumber *)minor NS_DESIGNATED_INITIALIZER;

/**
 *  Convenience initializer for creating a new Beacon instance using CLBeacon.
 *
 *  @param beacon Instance of CLBeacon to take the values from.
 *
 *  @return New instance of Beacon that's created based on passed in CLBeacon.
 */
- (instancetype)initWithBeacon:(CLBeacon *)beacon;

/**
 *  Class utility method used for generating base data string from passed in CLBeacon instance.
 *
 *  @param beacon CLBeacon from whitch to get the base data.
 *
 *  @return NSString containing base data.
 */
+ (NSString *)baseDataFromBeacon:(CLBeacon *)beacon;


/**
 *  Method for getting base data that are based on beacon UUID, major and minor values.
 *
 *  @return NSString containing base data.
 */
- (NSString *)baseData;

@end
