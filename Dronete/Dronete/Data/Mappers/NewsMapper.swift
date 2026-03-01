//
//  NewsMapper.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

import Foundation

enum NewsMapper {
    static func map(_ dto: NewsDTO) -> News {
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: dto.publishedDate) ?? .distantPast

        return News(
            id: dto.id,
            title: dto.title,
            description: dto.description,
            imageURL: dto.imageURL.flatMap(URL.init(string:)),
            source: dto.source,
            publishedDate: date)
    }
}
