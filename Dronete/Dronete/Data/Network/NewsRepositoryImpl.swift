//
//  NewsRepositoryImpl.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

final class NewsRepositoryImpl: NewsRepository {
    private let service: NewsAPIService
    private let cacheStore: NewsCacheStore
    private var memoryCache: [News] = []

    init(service: NewsAPIService, cacheStore: NewsCacheStore) {
        self.service = service
        self.cacheStore = cacheStore
    }

    func fetchLatestNews(forceRefresh: Bool) async throws -> [News] {
        if !forceRefresh {
            if !memoryCache.isEmpty {
                return memoryCache
            }

            let persisted = try cacheStore.load().map(NewsCacheMapper.toDomain)
            if !persisted.isEmpty {
                memoryCache = persisted
                return persisted
            }
        }

        do {
            let dtos = try await service.fetchNews()
            let mapped = dtos.map(NewsMapper.map)
            memoryCache = mapped
            try? cacheStore.save(mapped.map(NewsCacheMapper.toCached))
            return mapped
        } catch {
            let persisted = (try? cacheStore.load().map(NewsCacheMapper.toDomain)) ?? []
            if !persisted.isEmpty {
                memoryCache = persisted
                return persisted
            }
            throw error
        }
    }
}
