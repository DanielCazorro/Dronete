//
//  CachedNewsItem.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

import Foundation

struct CachedNewsItem: Codable {
    let id: String
    let title: String
    let description: String
    let imageURL: String?
    let source: String
    let publishedDate: String
}
