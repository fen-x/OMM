//
//  NSCalendar+ISO8601.swift
//  OMM
//
//  Created by Ivan Nikitin on 1/11/16.
//  Copyright © 2016 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSCalendar
import var   Foundation.NSCalendarIdentifierISO8601

extension NSCalendar {

    static
    var ISO8601: NSCalendar? {
        return NSCalendar(identifier: NSCalendarIdentifierISO8601)
    }

}
