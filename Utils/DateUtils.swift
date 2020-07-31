//
//  DateUtils.swift
//  SoccerRadar
//
//  Created by Egor on 31/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class Date {
    private static let formatter = DateFormatter()
    
    static func formattedDate(date: Date, format: String) -> String {
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
