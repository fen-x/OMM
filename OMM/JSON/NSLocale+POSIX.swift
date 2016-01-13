//
//  NSLocale+POSIX.swift
//  OMM
//
//  Created by Ivan Nikitin on 1/11/16.
//  Copyright © 2016 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSLocale

extension NSLocale {

    static
    var POSIX: NSLocale? {
        return NSLocale(localeIdentifier: "en_US_POSIX")
    }

}
