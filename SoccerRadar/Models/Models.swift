//
//  News.swift
//  SoccerRadar
//
//  Created by Egor on 15/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation

struct Response: Codable {
    var articles: [News]
}

struct News: Codable {
    var title: String
    var source: Source
    var publishedAt: Date?
    var urlToImage: String?
    var content: String?
}

struct Source: Codable {
    var name: String?
}

