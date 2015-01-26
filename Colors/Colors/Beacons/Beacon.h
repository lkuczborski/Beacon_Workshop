//
//  Beacon.h
//  Colors
//
//  Created by Lukasz Stocki on 22.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

@import Foundation;
@import CoreLocation;

@interface Beacon : NSObject

@property (nonatomic, copy) NSString *uuid;

@property (nonatomic, strong) NSNumber *major;
@property (nonatomic, strong) NSNumber *minor;

@property (assign, nonatomic) CLProximity proximity;

@property (assign, readwrite, nonatomic) CLLocationAccuracy accuracy;
@property (assign, readonly) CLLocationAccuracy accuracyMax;
@property (assign, readonly) CLLocationAccuracy accuracyMin;

@property (assign, nonatomic) NSInteger rssi;
@property (assign, readonly) NSInteger rssiMax;
@property (assign, readonly) NSInteger rssiMin;

- (instancetype)initWithUUID:(NSString *)uuid
                       major:(NSNumber *)major
                       minor:(NSNumber *)minor NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithBeacon:(CLBeacon *)beacon;

+ (NSString *)baseDataFromBeacon:(CLBeacon *)beacon;

- (NSString *)baseData;

@end
