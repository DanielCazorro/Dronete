//
//  News.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

import Foundation

struct News: Equatable {
    let id: String
    let title: String
    let description: String
    let imageURL: URL?
    let source: String
    let publishedDate: Date
}
