//
//  PorkHandler.swift
//  ProkKit
//
//  Created by Lukasz Stocki on 11/02/16.
//  Copyright © 2016 A.C.M.E. All rights reserved.
//

import Foundation
import CoreLocation

enum PorkHandlerErrors: ErrorType {
    case TooManyRegions(message: String)
    case MissingKeysInPlisFile(keys:[String])
}

protocol PorkEventHandler: class { // 💩
    func porkHandlerDidUpdateBeacons(porkHandler: PorkHandler, beacons: [Pork])
}

class PorkHandler: NSObject {
    private(set) weak var eventHandler: PorkEventHandler?

    private let PorkLimit = 20
    private var isRunning = false

    private let locationManager: CLLocationManager
    private var porkRegions    : [PorkRegion]
    private var handledBeacons : [String : Pork] = [:]

    init(porkRegions: [PorkRegion], porkEventHandler: PorkEventHandler? = nil) throws {

        self.porkRegions = porkRegions
        eventHandler = porkEventHandler

        locationManager = CLLocationManager.init()

        super.init()

        locationManager.delegate = self

        // Evry thing has to be assig before I can return nil or return in any way...
        if porkRegions.count <= PorkLimit {
            let message = "💥iOS Applications have a limit of \(PorkLimit) regions that can be monitered"
            throw PorkHandlerErrors.TooManyRegions(message: message)
        }
    }

    func start() {
        if isRunning == false {
            isRunning = true

            registerRegions()
        }
    }
}

private extension PorkHandler {

    func registerRegions() {
        porkRegions
            .map {
                CLBeaconRegion.init(porkRegion: $0)
            }
            .forEach {
                self.locationManager.startMonitoringForRegion($0)
                self.locationManager.startRangingBeaconsInRegion($0)
        }
    }

    func validateInfoPlist() throws {
        // TODO: validate plist keys and throw an error if they are missing in the bundle...
    }

}

extension PorkHandler: CLLocationManagerDelegate {

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {

        if case CLAuthorizationStatus.AuthorizedAlways = status {
            start()
            self.locationManager .startUpdatingLocation()
        }
        else if case CLAuthorizationStatus.NotDetermined = status {
            self.locationManager .requestAlwaysAuthorization()
        }
    }

    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {

        let processedPork: [Pork] =
            beacons.map{ (clb: CLBeacon) -> Pork in   // convert beacon to Pork! with all proximity/accuracy/rssi pass along
                return Pork.init(beacon: clb)
            }

        // Can't chaing forEach beacouse it returns "()" :(
        for pork in processedPork {
                let storedPork = self.handledBeacons[pork.commonDescription]

                if storedPork == nil {
                    self.handledBeacons[pork.commonDescription] = pork
                }
        }

        eventHandler?.porkHandlerDidUpdateBeacons(self, beacons: processedPork)
    }
}

private extension CLBeaconRegion {
     convenience init(porkRegion: PorkRegion) {
        // It's imposible ;) to create a PorkRegion with invalid UUID string!
        let uuid = NSUUID.init(UUIDString: porkRegion.uuid)!

        self.init(proximityUUID: uuid, identifier: porkRegion.name)

        self.notifyOnEntry = true
        self.notifyOnExit  = true
        self.notifyEntryStateOnDisplay = true
    }
}

private extension Pork {

    // Regular description may be changed in Pork and that would brake other functionality.
    var commonDescription: String {
        return "UUID: \(self.uuid) Major: \(self.major) Minor: \(self.minor)"
    }
}
