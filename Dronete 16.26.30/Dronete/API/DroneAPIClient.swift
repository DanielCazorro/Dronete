//
//  DroneAPIClient.swift
//  Dronete
//
//  Created by Daniel Cazorro on 24/5/25.
//

import Foundation

class DroneAPIClient {
    func fetchDrones(completion: @escaping (Result<[Drone], Error>) -> Void) {
        let droneListURLString = "https://github.com/dronetag/opendronelist/releases/download/20230904-2037/models.json"

        guard let droneListURL = URL(string: droneListURLString) else {
            print("❌ Error: URL inválida")
            completion(.failure(ApiError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: droneListURL) { responseData, urlResponse, error in
            if let error {
                print("❌ Error de red: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            let range = (200...299)
            guard let httpResponse = urlResponse as? HTTPURLResponse, range.contains(httpResponse.statusCode) else {
                let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode
                print("❌ Respuesta inválida del servidor (\(statusCode ?? 0))")
                completion(.failure(ApiError.invalidResponse(statusCode: statusCode)))
                return
            }

            guard let responseData else {
                print("❌ No se recibió data")
                completion(.failure(ApiError.noData))
                return
            }

            print("📥 Datos recibidos de la API")

            if let jsonString = String(data: responseData, encoding: .utf8) {
                print("🧾 Respuesta JSON:\n\(jsonString.count)")
            }

            do {
                let decodedDrones = try JSONDecoder().decode(Drones.self, from: responseData)
                print("✅ Drones decodificados correctamente (\(decodedDrones.count) modelos)")
                completion(.success(decodedDrones))
            } catch {
                print("❌ Error al decodificar JSON: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
