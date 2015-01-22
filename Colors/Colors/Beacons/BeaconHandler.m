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

@end

@implementation BeaconHandler

- (instancetype)initWithBeaconRegions:(NSArray *)regions
                            delegate:(id<BeaconEventHandler>)delegate
{
    self = [super init];
    if (self) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        
        _delegate = delegate;
        
        [self registerRegions:regions];
    }
    return self;
}

- (void)registerRegions:(NSArray *)regions
{
    NSAssert((regions.count <= RegionsLimit), @"iOS applications have limit on max amount of regions");
    
    for (BeaconRegion *region in regions) {
        [self startMonitoringBeaconInRegion:region];
    }
}

- (void)startMonitoringBeaconInRegion:(BeaconRegion *)region
{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:region.uuid];
}

#pragma mark - CLLocationManagerDelegate

@end
