//
//  MainViewDataManager.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 29/4/24.
//

import Foundation

class MainViewDataManager {
    
    // Cliente de la API para obtener los datos
    private let apiClient: MainViewApiClient
    
    init(apiClient: MainViewApiClient = MainViewApiClient()) {
        self.apiClient = apiClient
    }
    
    // Método para obtener los datos de la API a través del cliente de la API
    func fetchData(completion: @escaping (Result<[Drone], Error>) -> Void) {
        apiClient.fetchData(completion: completion)
    }
}
