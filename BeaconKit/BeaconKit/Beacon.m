//
//  Beacon.m
//  Colors
//
//  Created by Lukasz Stocki on 22.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import "Beacon.h"

#import <float.h>

@interface Beacon ()

@property (assign, readwrite) CLLocationAccuracy accuracyMax;
@property (assign, readwrite) CLLocationAccuracy accuracyMin;

@property (assign, readwrite) NSInteger rssiMax;
@property (assign, readwrite) NSInteger rssiMin;

@end

@implementation Beacon

#pragma mark - Lifecycle

- (instancetype)initWithUUID:(NSString *)uuid
                       major:(NSNumber *)major
                       minor:(NSNumber *)minor
{
    self = [super init];
    if (self != nil) {
        _uuid = [uuid copy];
        _major = major;
        _minor = minor;
		
		_accuracyMax = DBL_MAX;
		_accuracyMin = DBL_MIN;
		
		//TODO: check if those values are Ok
		_rssiMax = NSIntegerMin;
		_rssiMin = NSIntegerMax;
    }
    return self;
}

- (instancetype)initWithBeacon:(CLBeacon *)beacon
{
	return [self initWithUUID:[beacon.proximityUUID UUIDString]
						major:beacon.major
						minor:beacon.minor];
}

#pragma mark - Muttators
#pragma mark Accuracy
- (void)setAccuracy:(CLLocationAccuracy)accuracy
{
	if ([@(_accuracy) compare:@(accuracy)] == NSOrderedSame) {
		return;
	}
	
	if ([@(accuracy) compare:@(-1)] == NSOrderedSame) {
		return;
	}
	
	_accuracy = accuracy;
	
	[self updateMaxAccuracyWithAccuracy:accuracy];
	[self updateMinAccuracyWithAccuracy:accuracy];
}

- (void)updateMaxAccuracyWithAccuracy:(CLLocationAccuracy)accuracy
{
	if ([@(self.accuracyMax) compare:@(accuracy)] == NSOrderedDescending) {
		self.accuracyMax = accuracy;
	}
}

- (void)updateMinAccuracyWithAccuracy:(CLLocationAccuracy)accuracy
{
	if ([@(self.accuracyMin) compare:@(accuracy)] == NSOrderedAscending) {
		self.accuracyMin = accuracy;
	}
}

#pragma mark RSSI
- (void)setRssi:(NSInteger)rssi
{
	if (_rssi == rssi || rssi == 0) {
		return;
	}
	
	_rssi = rssi;
	[self updateMaxRSSIWithRSSI:rssi];
	[self updateMinRSSIWithRSSI:rssi];
}

- (void)updateMaxRSSIWithRSSI:(NSInteger)rssi
{
	if (self.rssiMax < rssi) {
		self.rssiMax = rssi;
	}
}

- (void)updateMinRSSIWithRSSI:(NSInteger)rssi
{
	if (self.rssiMin > rssi) {
		self.rssiMin = rssi;
	}
}

#pragma mark - Public API
+ (NSString *)baseDataFromBeacon:(CLBeacon *)beacon
{
	return [NSString stringWithFormat:@"UUID: %@\nMajor: %@\nMinor: %@",
			[beacon.proximityUUID UUIDString], [beacon.major stringValue], [beacon.minor stringValue]];
}

- (NSString *)baseData
{
	return [NSString stringWithFormat:@"UUID: %@\nMajor: %@\nMinor: %@",
			self.uuid, [self.major stringValue], [self.minor stringValue]];
}

#pragma mark - Helpers

-(NSString *)description
{
    NSString *description = [super description];
    
    return [NSString stringWithFormat:@"%@\n%@", description, [self baseData]];
}

@end
