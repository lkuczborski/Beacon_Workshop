//
//  PorkRegion.swift
//  ProkKit
//
//  Created by Lukasz Stocki on 10/02/16.
//  Copyright © 2016 A.C.M.E. All rights reserved.
//

import Foundation

public struct PorkRegion {
    let name: String
    let uuid: String

    init(name:String, uuid: String) {
        self.name = name
        self.uuid = uuid
    }
}
