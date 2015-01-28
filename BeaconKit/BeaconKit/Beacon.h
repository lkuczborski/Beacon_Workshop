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
@property (assign, readonly, nonatomic) CLLocationAccuracy accuracyMax;
@property (assign, readonly, nonatomic) CLLocationAccuracy accuracyMin;

@property (assign, nonatomic) NSInteger rssi;
@property (assign, readonly, nonatomic) NSInteger rssiMax;
@property (assign, readonly, nonatomic) NSInteger rssiMin;

@property (nonatomic, strong) NSNumber *customAccuracyMax;
@property (nonatomic, strong) NSNumber *customAccuracyMin;
@property (nonatomic, strong) NSNumber *customRSSIMax;
@property (nonatomic, strong) NSNumber *customRSSIMin;

- (instancetype)initWithUUID:(NSString *)uuid
                       major:(NSNumber *)major
                       minor:(NSNumber *)minor NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithBeacon:(CLBeacon *)beacon;

+ (NSString *)baseDataFromBeacon:(CLBeacon *)beacon;

- (NSString *)baseData;

@end
