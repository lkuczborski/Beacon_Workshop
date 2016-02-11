//
//  Beacon.swift
//  ProkKit
//
//  Created by Lukasz Stocki on 10/02/16.
//  Copyright © 2016 A.C.M.E. All rights reserved.
//

import Foundation
import CoreLocation;

struct Beacon {
    private(set) var uuid        : String
    private(set) var major       : CLBeaconMajorValue
    private(set) var minor       : CLBeaconMinorValue
    private(set) var proximity   : CLProximity

    private(set) var accuracy          : CLLocationAccuracy
    private(set) var accuracyMax       : CLLocationAccuracy?
    private(set) var accuracyMin       : CLLocationAccuracy?
    private(set) var customAccuracyMax : CLLocationAccuracy?
    private(set) var customAccuracyMin : CLLocationAccuracy?

    private(set) var rssi          : NSNumber
    private(set) var rssiMax       : NSNumber?
    private(set) var rssiMin       : NSNumber?
    private(set) var customRssiMax : NSNumber?
    private(set) var customRssiMin : NSNumber?

    init(uuid: String, major: CLBeaconMajorValue, minor: CLBeaconMinorValue) {
        self.uuid  = uuid
        self.major = major
        self.minor = minor

        self.accuracy = -1
        self.rssi = 0
        self.proximity = .Unknown
    }

    init(beacon: CLBeacon) {
        self.init(uuid: beacon.proximityUUID.UUIDString,
                 major: CLBeaconMajorValue(beacon.major.integerValue),
                 minor: CLBeaconMinorValue(beacon.minor.integerValue))
    }




// TODO:
// Convert this code in to a Swift nice code

//    #pragma mark - Muttators
//    #pragma mark Accuracy
//    - (void)setAccuracy:(CLLocationAccuracy)accuracy
//    {
//    if ([@(_accuracy) compare:@(accuracy)] == NSOrderedSame) {
//    return;
//    }
//
//    if ([@(accuracy) compare:@(-1)] == NSOrderedSame) {
//    return;
//    }
//
//    _accuracy = accuracy;
//
//    [self updateMaxAccuracyWithAccuracy:accuracy];
//    [self updateMinAccuracyWithAccuracy:accuracy];
//    }
//
//    - (void)updateMaxAccuracyWithAccuracy:(CLLocationAccuracy)accuracy
//    {
//    if ([@(self.accuracyMax) compare:@(accuracy)] == NSOrderedDescending) {
//    self.accuracyMax = accuracy;
//    }
//    }
//
//    - (void)updateMinAccuracyWithAccuracy:(CLLocationAccuracy)accuracy
//    {
//    if ([@(self.accuracyMin) compare:@(accuracy)] == NSOrderedAscending) {
//    self.accuracyMin = accuracy;
//    }
//    }
//
//    - (CLLocationAccuracy)accuracyMax
//    {
//    if (self.customAccuracyMax) {
//    return [self.customAccuracyMax doubleValue];
//    }
//
//    return _accuracyMax;
//    }
//
//    - (CLLocationAccuracy)accuracyMin
//    {
//    if (self.customAccuracyMin) {
//    return [self.customAccuracyMin doubleValue];
//    }
//
//    return _accuracyMin;
//    }
//
//    #pragma mark RSSI
//    - (void)setRssi:(NSInteger)rssi
//    {
//    if (_rssi == rssi || rssi == 0) {
//    return;
//    }
//
//    _rssi = rssi;
//    [self updateMaxRSSIWithRSSI:rssi];
//    [self updateMinRSSIWithRSSI:rssi];
//    }
//
//    - (void)updateMaxRSSIWithRSSI:(NSInteger)rssi
//    {
//    if (self.rssiMax < rssi) {
//    self.rssiMax = rssi;
//    }
//    }
//
//    - (void)updateMinRSSIWithRSSI:(NSInteger)rssi
//    {
//    if (self.rssiMin > rssi) {
//    self.rssiMin = rssi;
//    }
//    }
//
//    - (NSInteger)rssiMax
//    {
//    if (self.customRSSIMax) {
//    return [self.customRSSIMax integerValue];
//    }
//    
//    return _rssiMax;
//    }
//    
//    - (NSInteger)rssiMin
//    {
//    if (self.customRSSIMin) {
//    return [self.customRSSIMin integerValue];
//    }
//    
//    return _rssiMin;
//    }


}

extension Beacon: CustomStringConvertible {
    var description: String {
        return "UUID: \(self.uuid) Major: \(self.major) Minor: \(self.minor)"
    }
}

extension CLBeacon {
    var baseData: String {
        return "UUID: \(self.proximityUUID.UUIDString) Major: \(self.major) Minor: \(self.minor)"
    }
}