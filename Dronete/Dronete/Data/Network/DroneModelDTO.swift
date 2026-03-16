//
//  DroneModelDTO.swift
//  Dronete
//
//  Created by Daniel Cazorro on 16/3/26.
//

struct DroneModelDTO: Decodable {
    let id: String
    let brand: String
    let model: String
    let category: String
    let weightGrams: Int
    let maxFlightTimeMinutes: Int
    let cameraSpecs: String
    let rangeMeters: Int
    let imageURL: String?
}
