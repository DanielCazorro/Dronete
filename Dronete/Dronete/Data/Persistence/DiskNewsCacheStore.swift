//
//  DiskNewsCacheStore.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

import Foundation

final class DiskNewsCacheStore: NewsCacheStore {
    private let fileURL: URL
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(fileManager: FileManager = .default) {
        let baseURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
            ?? fileManager.temporaryDirectory
        self.fileURL = baseURL.appendingPathComponent("news_cache.json")
    }

    func load() throws -> [CachedNewsItem] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return [] }
        let data = try Data(contentsOf: fileURL)
        return try decoder.decode([CachedNewsItem].self, from: data)
    }

    func save(_ items: [CachedNewsItem]) throws {
        let data = try encoder.encode(items)
        try data.write(to: fileURL, options: .atomic)
    }

    func clear() throws {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return }
        try FileManager.default.removeItem(at: fileURL)
    }
}
