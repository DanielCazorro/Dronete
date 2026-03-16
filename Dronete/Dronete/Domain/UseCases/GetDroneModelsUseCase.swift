//
//  GetDroneModelsUseCase.swift
//  Dronete
//
//  Created by Daniel Cazorro on 16/3/26.
//

struct GetDroneModelsUseCase {
    private let repository: DroneModelRepository

    init(repository: DroneModelRepository) {
        self.repository = repository
    }

    func execute(forceRefresh: Bool) async throws -> [DroneModel] {
        try await repository.fetchDroneModels(forceRefresh: forceRefresh)
    }
}
