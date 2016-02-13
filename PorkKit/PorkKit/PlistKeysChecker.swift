//
//  PlistKeysChecker.swift
//  PorkKit
//
//  Created by Lukasz Stocki on 13/02/16.
//  Copyright © 2016 A.C.M.E. All rights reserved.
//

import Foundation

enum PlistKeysError: ErrorType {
    case MissingKeysInPlisFile(keys:[String])
}

typealias ValidationResult = (Bool, Bool)

enum PresentPlistKeyStatus {
    case AllwaysAndWhenInUse
    case WhenInUse
    case Allways
    case MissingRequiredPlistKeys

    init(allwaysKeyIsPresent a: Bool, whenInUseKeyIsPresent w: Bool) {
        switch (a, w) {
        case (true, true):
            self = .AllwaysAndWhenInUse

        case (true, false):
            self = .Allways

        case (false, true):
            self = .WhenInUse

        case (false, false):
            self = .MissingRequiredPlistKeys
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

        if case PresentPlistKeyStatus.MissingRequiredPlistKeys = result {
            throw PlistKeysError.MissingKeysInPlisFile(keys: [whenInUseKey, alwaysKey])
        }

        return result
    }

    func keysPresent() -> (allways: Bool, whenInUse: Bool) {
        let infoPlist = NSBundle.mainBundle().infoDictionary

        let allways   = infoPlist?[alwaysKey]    != nil
        let whenInUse = infoPlist?[whenInUseKey] != nil

        return (allways, whenInUse)
    }
}
