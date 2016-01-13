//
//  NSTimeZone+UTC.swift
//  OMM
//
//  Created by Ivan Nikitin on 1/11/16.
//  Copyright © 2016 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSTimeZone

extension NSTimeZone {

    static
    var UTC: NSTimeZone? {
        return NSTimeZone(name: "UTC")
    }

}
