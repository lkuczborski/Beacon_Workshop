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

#pragma mark - LiceCycle

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
		_rssiMax = NSIntegerMax;
		_rssiMin = NSIntegerMin;
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
	
	_accuracy = accuracy;
	
	[self updateMaxAccuracyWithAccuracy:accuracy];
	[self updateMinAccuracyWithAccuracy:accuracy];
}

- (void)updateMaxAccuracyWithAccuracy:(CLLocationAccuracy)accuracy
{
	self.accuracyMax = fmax(self.accuracyMax, accuracy);
}

- (void)updateMinAccuracyWithAccuracy:(CLLocationAccuracy)accuracy
{
	self.accuracyMin = fmin(self.accuracyMin, accuracy);
}

#pragma mark RSSI
- (void)setRssi:(NSInteger)rssi
{
	if (_rssi == rssi) {
		return;
	}
	
	_rssi = rssi;
	[self updateMaxRSSIWithRSSI:rssi];
	[self updateMinRSSIWithRSSI:rssi];
}

- (void)updateMaxRSSIWithRSSI:(NSInteger)rssi
{
	//TODO: check if that is right or should be reversed
	self.rssiMax = [@(fmax(self.rssiMax, rssi)) integerValue];
}

- (void)updateMinRSSIWithRSSI:(NSInteger)rssi
{
	//TODO: check if that is right or should be reversed
	self.rssiMin = [@(fmin(self.rssiMin, rssi)) integerValue];
}

#pragma mark - Helpers

-(NSString *)description
{
    NSString *description = [super description];
    
    return [NSString stringWithFormat:@"%@\nUUID: %@\nMajor: %@\nMinor: %@",
            description, self.uuid, [self.major stringValue], [self.minor stringValue]];
}

@end
