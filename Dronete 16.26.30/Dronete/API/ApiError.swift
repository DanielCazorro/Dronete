//
//  ApiError.swift
//  Dronete
//
//  Created by Daniel Cazorro on 24/5/25.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case invalidResponse(statusCode: Int?)
    case noData
    case decodingFailed
    case network(Error)
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL de la API no es válida."
        case .invalidResponse(let statusCode):
            if let statusCode {
                return "Respuesta inválida del servidor (código \(statusCode))."
            } else {
                return "Respuesta inválida del servidor."
            }
        case .noData:
            return "No se recibió ningún dato de la API."
        case .decodingFailed:
            return "No se pudieron interpretar los datos recibidos."
        case .network(let error):
            return "Error de red: \(error.localizedDescription)"
        }
    }
}
