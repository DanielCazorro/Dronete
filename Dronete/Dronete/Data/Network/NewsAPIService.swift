//
//  NewsAPIService.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

protocol NewsAPIService {
    func fetchNews() async throws -> [NewsDTO]
}
