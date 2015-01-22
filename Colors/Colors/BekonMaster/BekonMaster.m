//
//  BeaconMaster.m
//  Colors
//
//  Created by Lukasz Stocki on 22.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import "BeaconMaster.h"

static NSUInteger RegionsLimit = 20;

@interface BeaconMaster () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, weak) id <BeaconEventHandler> delegate;

@end

@implementation BeaconMaster

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
    NSAssert(uuid, <#desc, ...#>)
}

#pragma mark - CLLocationManagerDelegate

@end
