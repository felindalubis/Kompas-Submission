//
//  Date+extension.swift
//  Kompas-Submission
//
//  Created by Felinda Gracia Lubis on 07/01/22.
//

import Foundation

extension Double {
    public enum DateStyle {
        case full, date, time
    }
    
    func getStringDate(dateStyle: DateStyle) -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        
        switch dateStyle {
        case .full:
            dateFormatter.timeStyle = DateFormatter.Style.medium
            dateFormatter.dateStyle = DateFormatter.Style.short
        case .date:
            dateFormatter.timeStyle = DateFormatter.Style.none
            dateFormatter.dateStyle = DateFormatter.Style.short
        case .time:
            dateFormatter.timeStyle = DateFormatter.Style.short
            dateFormatter.dateStyle = DateFormatter.Style.none
        }
        
        let localDate = dateFormatter.string(from: date)

        return localDate
    }
}
