//
//  PorkRegion.swift
//  ProkKit
//
//  Created by Lukasz Stocki on 10/02/16.
//  Copyright © 2016 A.C.M.E. All rights reserved.
//

import Foundation

struct PorkRegion {
    private(set) let name: String
    private(set) let uuid: String

    init(name name:String, uuid: String) {
        self.name = name
        self.uuid = uuid
    }
}
