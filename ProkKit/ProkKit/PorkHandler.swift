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
}

protocol PorkEventHandler: class { // 💩
    func porkHandlerDidUpdateBeacons(porkHandler: PorkHandler, beacons: [CLBeacon])
}

class PorkHandler: NSObject, CLLocationManagerDelegate {
    private(set) weak var eventHandler: PorkEventHandler?

    private let PorkLimit = 20
    private var isRunning = false

    private let locationManager: CLLocationManager
    private var porkRegions: [PorkRegion]

    init(porkRegions: [PorkRegion], porkEventHandler: PorkEventHandler? = nil) throws {

        self.porkRegions = porkRegions
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