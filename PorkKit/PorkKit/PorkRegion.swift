//
//  PorkRegion.swift
//  ProkKit
//
//  Created by Lukasz Stocki on 10/02/16.
//  Copyright © 2016 A.C.M.E. All rights reserved.
//

import Foundation

enum PorkRegionError: ErrorType {
    case InvalidUUID
}

public struct PorkRegion {
    let name: String
    let uuid: String

    init(name: String, uuid: String) throws {
        guard let _ = NSUUID.init(UUIDString: uuid) else {
            throw PorkRegionError.InvalidUUID
        }

        self.name = name
        self.uuid = uuid
    }

}
