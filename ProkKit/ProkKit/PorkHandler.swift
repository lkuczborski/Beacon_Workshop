//
//  PorkHandler.swift
//  ProkKit
//
//  Created by Lukasz Stocki on 11/02/16.
//  Copyright © 2016 A.C.M.E. All rights reserved.
//

import Foundation
import CoreLocation

protocol PorkEventHandler: class { // 💩

}

class PorkHandler {
    private(set) weak var eventHandler: PorkEventHandler?

    init() {

    }
}