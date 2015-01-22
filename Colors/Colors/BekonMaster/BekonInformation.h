//
//  BeaconInformation.h
//  Colors
//
//  Created by Lukasz Stocki on 22.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

@import Foundation;
@import CoreLocation;

@interface BeaconInformation : NSObject

@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSNumber *major;
@property (nonatomic, strong) NSNumber *minor;

@property (assign, nonatomic) CLProximity proximity;
@property (assign, nonatomic) CLLocationAccuracy accuracy;
@property (assign, nonatomic) NSInteger rssi;

- (instancetype)initWithUUID:(NSString *)uuid
                        name:(NSString *)name
                       major:(NSNumber *)major
                       minor:(NSNumber *)minor NS_DESIGNATED_INITIALIZER;

@end
