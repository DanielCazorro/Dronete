//
//  MainViewApiClient.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 29/4/24.
//

import Foundation

class MainViewApiClient {
    
    // Método para obtener los datos de la API
    func fetchData(completion: @escaping (Result<[Drone], Error>) -> Void) {
        guard let url = URL(string: "https://github.com/dronetag/opendronelist/releases/download/20230904-2037/models.json") else {
            completion(.failure(ApiError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(ApiError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(Drones.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// Enum para manejar los posibles errores de la API
enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case noData
}
