//
//  NewsCacheStore.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

protocol NewsCacheStore {
    func load() throws -> [CachedNewsItem]
    func save(_ items: [CachedNewsItem]) throws
    func clear() throws
}
