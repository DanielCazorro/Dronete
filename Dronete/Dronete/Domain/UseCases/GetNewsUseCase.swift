//
//  GetNewsUseCase.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

struct GetNewsUseCase {
    private let repository: NewsRepository

    init(repository: NewsRepository) {
        self.repository = repository
    }

    func execute(forceRefresh: Bool) async throws -> [News] {
        try await repository.fetchLatestNews(forceRefresh: forceRefresh)
    }
}
