//
//  PlistKeysChecker.swift
//  PorkKit
//
//  Created by Lukasz Stocki on 13/02/16.
//  Copyright © 2016 A.C.M.E. All rights reserved.
//

import Foundation

enum PlistKeysError: ErrorProtocol {
    case missingKeysInPlisFile(keys: [String])
}

enum PresentPlistKeyStatus {
    case allwaysAndWhenInUse
    case whenInUse
    case allways
    case missingRequiredPlistKeys

    init(allwaysKeyIsPresent a: Bool, whenInUseKeyIsPresent w: Bool) {
        switch (a, w) {
        case (true, true):
            self = .allwaysAndWhenInUse

        case (true, false):
            self = .allways

        case (false, true):
            self = .whenInUse

        case (false, false):
            self = .missingRequiredPlistKeys
        }
    }
}

class PlistKeysChecker {

    private let whenInUseKey = "NSLocationWhenInUseUsageDescription"
    private let alwaysKey    = "NSLocationAlwaysUsageDescription"

    private(set) var validationResult: PresentPlistKeyStatus?

    init() {}

    func validate() throws -> PresentPlistKeyStatus {

        let keyStatus = keysPresent()

        let result = PresentPlistKeyStatus.init(allwaysKeyIsPresent: keyStatus.allways,
                                              whenInUseKeyIsPresent: keyStatus.whenInUse)
        self.validationResult = result
        

        if case PresentPlistKeyStatus.missingRequiredPlistKeys = result {
            throw PlistKeysError.missingKeysInPlisFile(keys: [whenInUseKey, alwaysKey])
        }

        return result
    }

    func keysPresent() -> (allways: Bool, whenInUse: Bool) {
        let infoPlist = Bundle.main.infoDictionary

        let allways   = infoPlist?[alwaysKey]    != nil
        let whenInUse = infoPlist?[whenInUseKey] != nil

        return (allways, whenInUse)
    }

}
