//
//  DateFormatter+Json.swift
//  OurRecipes
//
//  Created by Vanessa Hurla on 07/05/2023.
//

import Foundation

extension DateFormatter {
    static var serverDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    static var readableDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
