//
//  NewsCacheMapper.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

import Foundation

enum NewsCacheMapper {
    private static let formatter = ISO8601DateFormatter()

    static func toCached(_ news: News) -> CachedNewsItem {
        CachedNewsItem(
            id: news.id,
            title: news.title,
            description: news.description,
            imageURL: news.imageURL?.absoluteString,
            source: news.source,
            publishedDate: formatter.string(from: news.publishedDate)
        )
    }

    static func toDomain(_ item: CachedNewsItem) -> News {
        News(
            id: item.id,
            title: item.title,
            description: item.description,
            imageURL: item.imageURL.flatMap(URL.init(string:)),
            source: item.source,
            publishedDate: formatter.date(from: item.publishedDate) ?? .distantPast
        )
    }
}
