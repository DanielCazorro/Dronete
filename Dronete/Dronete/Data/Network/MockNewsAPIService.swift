//
//  MockNewsAPIService.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

import Foundation

final class MockNewsAPIService: NewsAPIService {
    func fetchNews() async throws -> [NewsDTO] {
        try await Task.sleep(nanoseconds: 700_000_000)

        return [
            NewsDTO(
                id: "1",
                title: "Nueva normativa europea para vuelos urbanos",
                description: "Se actualizan los requisitos de seguridad para operaciones en ciudad.",
                imageURL: nil,
                source: "Drone Today",
                publishedDate: "2026-03-01T10:00:00Z"
            ),
            NewsDTO(
                id: "2",
                title: "Baterías de estado sólido en drones de inspección",
                description: "Prometen mayor autonomía y menor degradación.",
                imageURL: nil,
                source: "Aero News",
                publishedDate: "2026-02-28T18:30:00Z"
            )
        ]
    }
}
