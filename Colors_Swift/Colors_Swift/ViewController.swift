//
//  ViewController.swift
//  Colors_Swift
//
//  Created by Lukasz Kuczborski on 28.07.2016.
//  Copyright © 2016 Beacon Tech. All rights reserved.
//

import UIKit
import PorkKit

let RED_UUID = "430F6ED4-7E4F-4F63-85C7-845763861A55"
let BLUE_UUID = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
let GREEN_UUID = "3A7E7514-A9AC-41F3-A236-3CFCE75BAC95"

class ViewController: UIViewController {

    var handler: PorkHandler?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.setupPorkHandler()
    }

    // MARK: PorkHandler

    func setupPorkHandler() {

        guard let redRegion: PorkRegion = try? PorkRegion(name: "Estimote Mint Cocktail", uuid: RED_UUID),
              let blueRegion: PorkRegion = try? PorkRegion(name: "Estimote Icy Marshmallow", uuid: BLUE_UUID),
              let greenRegion: PorkRegion = try? PorkRegion(name: "Estimote Blueberry Pie", uuid: GREEN_UUID)
        else {
            return
        }

        let regions = [redRegion, blueRegion, greenRegion]

        do {
            handler = try PorkHandler(porkRegions: regions, porkEventHandler: self)
            try handler?.start()
        } catch {
            print("Error: \(error)")
        }
    }

    func getComponentValueFromBeacon(_ beacon: Pork) -> CGFloat {

        var normalized: CGFloat = 0.5

        // some more hints using proximity
        if beacon.proximity == .immediate {
            normalized += 0.5
        }
        else if beacon.proximity == .unknown {
            normalized -= 0.1
        }
        else if beacon.proximity == .near {
            normalized += 0.1
        }

        // checking the bounds again...
        if (normalized < 0) {
            normalized = 0.0001
        }
        
        if (normalized > 1) {
            normalized = 1
        }
        
        return normalized
    }

    func animateToColor(_ color: UIColor) {
        // TODO: find a nice way to animate this...
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.beginFromCurrentState, .curveEaseOut],
                       animations: {
                        self.view.layer.backgroundColor = color.cgColor
                        },
                       completion: nil)
    }
}

// MARK: PorkEventHandler

extension ViewController: PorkEventHandler {

    func porkHandlerDidUpdateBeacons(_ porkHandler: PorkHandler, beacons: [Pork]) {

        let currentColor: UIColor = UIColor(cgColor: view.layer.backgroundColor!)
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        currentColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        for beacon in beacons {
            switch beacon.uuid {
            case RED_UUID:
                r = getComponentValueFromBeacon(beacon)
            case GREEN_UUID:
                g = getComponentValueFromBeacon(beacon)
            case BLUE_UUID:
                b = getComponentValueFromBeacon(beacon)
            default:
                break
            }
        }

        print("R: \(r), G: \(g), B: \(b)")
        self.animateToColor(UIColor(red: r, green: g, blue: b, alpha: a))
    }
}
