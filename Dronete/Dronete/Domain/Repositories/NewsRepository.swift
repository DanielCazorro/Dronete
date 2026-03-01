//
//  NewsRepository.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

protocol NewsRepository {
    func fetchLatestNews(forceRefresh: Bool) async throws -> [News]
}
