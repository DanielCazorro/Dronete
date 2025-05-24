//
//  DroneRepository.swift
//  Dronete
//
//  Created by Daniel Cazorro on 24/5/25.
//

import Foundation

protocol DroneRepositoryProtocol {
    func fetchDrones(completion: @escaping (Result<[Drone], Error>) -> Void)
}

final class DroneRepository: DroneRepositoryProtocol {
    private let apiClient: DroneAPIClient

    init(apiClient: DroneAPIClient = DroneAPIClient()) {
        self.apiClient = apiClient
    }

    func fetchDrones(completion: @escaping (DroneResult) -> Void) {
        #if DEBUG
        print("📡 DroneRepository: solicitando datos de drones...")
        #endif
        apiClient.fetchDrones(completion: completion)
    }
}

typealias DroneResult = Result<[Drone], Error>
