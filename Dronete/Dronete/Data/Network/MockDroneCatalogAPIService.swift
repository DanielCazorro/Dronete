//
//  MockDroneCatalogAPIService.swift
//  Dronete
//
//  Created by Daniel Cazorro on 16/3/26.
//

import Foundation

final class MockDroneCatalogAPIService: DroneCatalogAPIService {
    func fetchModels() async throws -> [DroneModelDTO] {
        try await Task.sleep(nanoseconds: 500_000_000)
        return [
            .init(id: "m1", brand: "DJI", model: "Mini 4 Pro", category: "Recreativo", weightGrams: 249, maxFlightTimeMinutes: 34, cameraSpecs: "4K/60fps", rangeMeters: 10000, imageURL: nil),
            .init(id: "m2", brand: "Autel", model: "EVO Lite+", category: "Fotografía", weightGrams: 835, maxFlightTimeMinutes: 40, cameraSpecs: "6K", rangeMeters: 12000, imageURL: nil),
            .init(id: "m3", brand: "Parrot", model: "Anafi Ai", category: "Inspección", weightGrams: 898, maxFlightTimeMinutes: 32, cameraSpecs: "48MP", rangeMeters: 9000, imageURL: nil)
        ]
    }
}
