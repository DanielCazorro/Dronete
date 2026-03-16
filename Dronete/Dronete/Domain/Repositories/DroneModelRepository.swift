//
//  DroneModelRepository.swift
//  Dronete
//
//  Created by Daniel Cazorro on 16/3/26.
//

protocol DroneModelRepository {
    func fetchDroneModels(forceRefresh: Bool) async throws -> [DroneModel]
}
