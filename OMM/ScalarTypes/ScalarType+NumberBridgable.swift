//
//  ScalarType+NumberBridgable.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSNumber

extension NSNumber: ScalarType { }

extension Int: ScalarType { }

extension UInt: ScalarType { }

extension Float: ScalarType { }

extension Double: ScalarType { }

extension Bool: ScalarType { }
