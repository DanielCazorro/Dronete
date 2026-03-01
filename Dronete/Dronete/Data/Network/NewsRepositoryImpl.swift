//
//  NewsRepositoryImpl.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

final class NewsRepositoryImpl: NewsRepository {
    private let service: NewsAPIService
    private var cache: [News] = []

    init(service: NewsAPIService) {
        self.service = service
    }

    func fetchLatestNews(forceRefresh: Bool) async throws -> [News] {
        if !forceRefresh, !cache.isEmpty {
            return cache
        }

        let dtos = try await service.fetchNews()
        let mapped = dtos.map(NewsMapper.map)
        cache = mapped
        return mapped
    }
}
