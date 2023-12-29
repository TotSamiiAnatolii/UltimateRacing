//
//  DateFormatter+.swift
//  UltimateRacing
//
//  Created by APPLE on 29.12.2023.
//

import Foundation

extension DateFormatter {
    
    static  func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
}
