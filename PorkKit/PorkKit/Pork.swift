//
//  Beacon.swift
//  ProkKit
//
//  Created by Lukasz Stocki on 10/02/16.
//  Copyright © 2016 A.C.M.E. All rights reserved.
//

import Foundation
import CoreLocation;

public struct Pork {

    private(set) var major    : CLBeaconMajorValue
    private(set) var minor    : CLBeaconMinorValue
    private(set) var proximity: CLProximity
    private(set) var rssi     : Int
    private(set) var uuid     : String

    private(set) var accuracy: CLLocationAccuracy {
        set {
            if case let newAccuracy = newValue where newAccuracy != self.accuracy && newAccuracy != -1 {
                self.accuracy = newAccuracy
            }
        }

        get {
            return self.accuracy
        }
    }

    init(uuid: String, major: CLBeaconMajorValue, minor: CLBeaconMinorValue) {

        self.uuid  = uuid
        self.major = major
        self.minor = minor

        proximity = .Unknown
        rssi      = 0
        accuracy  = -1;
    }

    init(beacon: CLBeacon) {
        self.init(uuid: beacon.proximityUUID.UUIDString,
                 major: CLBeaconMajorValue(beacon.major.integerValue),
                 minor: CLBeaconMinorValue(beacon.minor.integerValue))

        proximity = beacon.proximity
        accuracy  = beacon.accuracy
        rssi      = beacon.rssi
    }

}

extension Pork: CustomStringConvertible {
    public var description: String {
        return "UUID: \(self.uuid) Major: \(self.major) Minor: \(self.minor)"
    }

}

extension Pork: CustomDebugStringConvertible {
    public var debugDescription: String {
        return self.description
    }

}

extension CLBeacon {
    var baseData: String {
        return "UUID: \(self.proximityUUID.UUIDString) Major: \(self.major) Minor: \(self.minor)"
    }
}
