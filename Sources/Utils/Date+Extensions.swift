//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation

extension Date {
    
    var asISO8601DateString: String {
        let formatter = Date.iso8601Formatter
        return formatter.string(from: self)
    }
    
    var asYYYYMMDD: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    static func fromISO8601DateString(_ dateString: String) -> Date? {
        return Date.iso8601Formatter.date(from: dateString)
    }
    
    private static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        return formatter
    }()
}
