//
//  PorkHandler.swift
//  ProkKit
//
//  Created by Lukasz Stocki on 11/02/16.
//  Copyright © 2016 A.C.M.E. All rights reserved.
//

import Foundation
import CoreLocation

enum PorkHandlerErrors: ErrorProtocol {
    case tooManyRegions(message: String)
}

protocol PorkEventHandler: class { // 💩
    func porkHandlerDidUpdateBeacons(_ porkHandler: PorkHandler, beacons: [Pork])
}

class PorkHandler: NSObject {
    private(set) weak var eventHandler: PorkEventHandler?

    private let PorkLimit      = 20
    private var isRunning      = false
    private var plistValidator = PlistKeysChecker()

    private let locationManager: CLLocationManager
    private let porkRegions    : [PorkRegion]
    private var handledBeacons : [String : Pork] = [:]

    init(porkRegions: [PorkRegion], porkEventHandler: PorkEventHandler? = nil) throws {

        self.porkRegions = porkRegions
        eventHandler = porkEventHandler

        locationManager = CLLocationManager.init()

        super.init()

        locationManager.delegate = self

        // Evry thing has to be assig before I can return nil or return in any way...
        if porkRegions.count >= PorkLimit {
            let message = "💥iOS Applications have a limit of \(PorkLimit) regions that can be monitered"
            throw PorkHandlerErrors.tooManyRegions(message: message)
        }
    }

    func start() throws {
        if isRunning == false {
            isRunning = true

            try plistValidator.validate()

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
                self.locationManager.startMonitoring(for: $0)
                self.locationManager.startRangingBeacons(in: $0)
        }
    }

    func requestForLocationManagerAuthorization() {

        switch self.plistValidator.validationResult {

            case .allwaysAndWhenInUse?, .allways?:
                self.locationManager .requestAlwaysAuthorization()

            case .whenInUse?:
                self.locationManager.requestWhenInUseAuthorization()

            default:
                break
        }
    }

}

extension PorkHandler: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {

            case .authorizedAlways, .authorizedWhenInUse:
                try! start()
                self.locationManager .startUpdatingLocation()

            case .notDetermined:
                requestForLocationManagerAuthorization()

            default:
                break
        }
    }

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {

        let processedPork: [Pork] =
            beacons.map { (clb: CLBeacon) -> Pork in   // convert beacon to Pork! with all proximity/accuracy/rssi pass along
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
        let uuid = UUID.init(uuidString: porkRegion.uuid)!

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
