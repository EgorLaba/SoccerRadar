//
//  DateUtils.swift
//  SoccerRadar
//
//  Created by Egor on 01/08/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class DateUtils {
    
    // MARK: - Variables
    
    static let fullDateFormat = "MM-dd-yyyy HH:mm"
    
    private static let formatter = DateFormatter()
    
    
    static func formattedDate(date: Date, format: String) -> String {
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
