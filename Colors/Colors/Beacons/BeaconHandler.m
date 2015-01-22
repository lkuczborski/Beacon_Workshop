//
//  BeaconHandler.m
//  Colors
//
//  Created by Lukasz Stocki on 22.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import "BeaconHandler.h"

static NSUInteger RegionsLimit = 20;

@interface BeaconHandler () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, weak) id <BeaconEventHandler> delegate;

@property (nonatomic, strong) NSMutableArray *beacons;
@property (nonatomic, copy) NSArray *regions;

@property (nonatomic, assign, getter=isRunning) BOOL running;

@end

@implementation BeaconHandler

- (instancetype)initWithBeaconRegions:(NSArray *)regions
                            delegate:(id<BeaconEventHandler>)delegate
{
    NSAssert((regions.count <= RegionsLimit), @"iOS applications have limit on max amount of regions");
    
    self = [super init];
    if (self) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        
        _beacons = [NSMutableArray array];
        
        _delegate = delegate;
        
        _regions = [regions copy];
    }
    return self;
}

- (void)start
{
    if (self.isRunning == NO) {
        self.isRunning = YES;
        
        [self registerRegions];
    }
}

- (void)registerRegions
{
    for (BeaconRegion *region in self.regions) {
        [self startMonitoringBeaconInRegion:region];
        [self.bea]
    }
}

- (CLBeaconRegion *)startMonitoringBeaconInRegion:(BeaconRegion *)region
{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:region.uuid];
    NSAssert(uuid != nil, @"UUID should be non nil");
    
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                identifier:butcher.name];
    
    region.notifyOnEntry             = YES;
    region.notifyOnExit              = YES;
    region.notifyEntryStateOnDisplay = YES;
    
    [_locationManager startMonitoringForRegion:region];
    [_locationManager startRangingBeaconsInRegion:region];
}

#pragma mark - CLLocationManagerDelegate

@end
