//
//  DroneCatalogAPIService.swift
//  Dronete
//
//  Created by Daniel Cazorro on 16/3/26.
//

protocol DroneCatalogAPIService {
    func fetchModels() async throws -> [DroneModelDTO]
}
