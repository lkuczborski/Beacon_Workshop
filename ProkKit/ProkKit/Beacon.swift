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