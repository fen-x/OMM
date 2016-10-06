//
//  DateTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Transformation that transforms node to `Date` value
/// in case of date represented as the formatted string.
public
struct DateTransform: Transform {

    private
    let formatter: DateFormatter

    /// Creates an instance of `DateTransform` initilized with given date format string.
    ///
    /// - Parameter dateFormat: Date format.
    /// - Note: The formatter defaults to having the ISO 8601 calendar, `en_US_POSIX` locale and UTC time zone, for those properties.
    public
    init(dateFormat: String) {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        self.init(formatter: formatter)
    }

    /// Creates an instance of `DateTransform` initilized with given date formatter.
    ///
    /// - Parameter formatter: Date formatter.
    public
    init(formatter: DateFormatter) {
        self.formatter = formatter.copy() as! DateFormatter
    }

    /// Transforms node to `Date` value.
    ///
    /// - Parameter node: Node.
    /// - Returns: `Date` instance.
    /// - Throws: `MappingError`, `TransformError` if `String` value of node does not represent correctly formatted date.
    public
    func apply(to node: Node) throws -> Date {
        guard let value = try formatter.date(from: node.value(String.self)) else {
            throw error(reason: "Unexpected date format")
        }
        return value
    }

}

public
extension DateTransform {

    /// Date transformation working with dates formatted using ISO 8601 standard.
    ///
    /// - Note: Transformation covers only `yyyy-MM-dd'T'HH:mm:ssZZZZZ` format.
    public
    static var iso8601: DateTransform {
        return DateTransform(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
    }
    
}
