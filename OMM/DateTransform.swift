//
//  DateTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSDate
import class Foundation.NSDateFormatter
import class Foundation.NSCalendar
import var   Foundation.NSCalendarIdentifierISO8601
import class Foundation.NSLocale

public
struct DateTransform: TransformType {

    private
    let formatter: NSDateFormatter

    public
    init(dateFormat: String) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        self.init(formatter: formatter)
    }

    public
    init(formatter: NSDateFormatter) {
        self.formatter = formatter.copy() as! NSDateFormatter
    }

    public
    func applyToNode(node: NodeType) throws -> NSDate {
        guard let value = try formatter.dateFromString(node.value()) else {
            throw errorWithReason("Unexpected date format")
        }
        return value
    }

}

public
extension DateTransform {

    public
    static var ISO8601: DateTransform {
        let formatter = NSDateFormatter()
        formatter.calendar = NSCalendar(identifier: NSCalendarIdentifierISO8601)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return DateTransform(formatter: formatter)
    }
    
}
