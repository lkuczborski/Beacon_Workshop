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

@property (nonatomic, strong) NSMutableDictionary *handledBeacons;

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
		_handledBeacons = [NSMutableDictionary dictionary];
        
        _delegate = delegate;
        
        _regions = [regions copy];
    }
    return self;
}

- (void)start
{
    if (self.isRunning == NO) {
        self.running = YES;
        
        [self registerRegions];
    }
}

- (void)registerRegions
{
    for (BeaconRegion *region in self.regions) {
        [self startMonitoringBeaconInRegion:region];
    }
}

- (CLBeaconRegion *)startMonitoringBeaconInRegion:(BeaconRegion *)inRegion
{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:inRegion.uuid];
    NSAssert(uuid != nil, @"UUID should be non nil");
    
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                identifier:inRegion.name];
    
    region.notifyOnEntry             = YES;
    region.notifyOnExit              = YES;
    region.notifyEntryStateOnDisplay = YES;
    
    [_locationManager startMonitoringForRegion:region];
    [_locationManager startRangingBeaconsInRegion:region];
	
	return region;
}

#pragma mark - Private API

- (Beacon *)updateBeacon:(CLBeacon *)beacon
{
	Beacon *handledBeacon = [self handledBeaconForBeacon:beacon];
	NSAssert(handledBeacon != nil, @"This should not be nil!");
	
	handledBeacon.proximity = beacon.proximity;
	handledBeacon.accuracy = beacon.accuracy;
	handledBeacon.rssi = beacon.rssi;
	
	return handledBeacon;
}

#pragma mark - Helper Methods

- (Beacon *)handledBeaconForBeacon:(CLBeacon *)beacon
{
	Beacon *handledBeacon = self.handledBeacons[[[Beacon alloc] initWithBeacon:beacon].baseData];
	
	if (handledBeacon == nil) {
		Beacon *newHandledBeacon = [[Beacon alloc] initWithBeacon:beacon];
		NSAssert(newHandledBeacon != nil, @"New beacon should be created.");
		
		self.handledBeacons[newHandledBeacon.baseData] = newHandledBeacon;
		handledBeacon = newHandledBeacon;
	}
	
	return handledBeacon;
}

#pragma mark - CLLocationManagerDelegate

- (void)        locationManager:(CLLocationManager *)manager
   didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
	if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
		
		[self start];
		
		[self.locationManager startUpdatingLocation];
	}
	else if (status == kCLAuthorizationStatusNotDetermined) {
		[self.locationManager requestWhenInUseAuthorization];
	}
}

- (void)locationManager:(CLLocationManager *)manager
		didRangeBeacons:(NSArray *)beacons
			   inRegion:(CLBeaconRegion *)region
{
	NSMutableArray *updatedBeacons = [NSMutableArray array];
	
	for (CLBeacon *beacon in beacons) {
		Beacon *updatedBeacon = [self updateBeacon:beacon];
		if (updatedBeacon) {
			
			[updatedBeacons addObject:updatedBeacon];
		}
	}
	
	[self.delegate beaconHandler:self
				didUpdateBeacons:[NSArray arrayWithArray:updatedBeacons]];
}

@end
