//
//  Promotion.swift
//  Jacaranda Card POS
//
//  Created by weng chong lao on 25/11/2022.
//

import Foundation

class Promotion: Identifiable, Decodable {
    
    var id: UUID?
    var title: String
    var status: String
    var startDateString: String
    var endDateString: String
    var description: String
    
    var startDate: Date {
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "dd MMM yy"

        // Convert String to Date
        if let dateUnwrap = dateFormatter.date(from: startDateString) {
            return dateUnwrap
        }
        return Date.now
    }
    
    var endDate: Date {
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "dd MMM yy"

        // Convert String to Date
        if let dateUnwrap = dateFormatter.date(from: endDateString) {
            return dateUnwrap
        }
        return Date.now
    }
}
