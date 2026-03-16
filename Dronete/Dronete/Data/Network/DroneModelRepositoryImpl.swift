//
//  DroneModelRepositoryImpl.swift
//  Dronete
//
//  Created by Daniel Cazorro on 16/3/26.
//

final class DroneModelRepositoryImpl: DroneModelRepository {
    private let service: DroneCatalogAPIService
    private var cache: [DroneModel] = []

    init(service: DroneCatalogAPIService) {
        self.service = service
    }

    func fetchDroneModels(forceRefresh: Bool) async throws -> [DroneModel] {
        if !forceRefresh, !cache.isEmpty { return cache }
        let dtos = try await service.fetchModels()
        let mapped = dtos.map(DroneModelMapper.map)
        cache = mapped
        return mapped
    }
}
