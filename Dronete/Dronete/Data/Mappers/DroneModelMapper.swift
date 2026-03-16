//
//  DroneModelMapper.swift
//  Dronete
//
//  Created by Daniel Cazorro on 16/3/26.
//

import Foundation

enum DroneModelMapper {
    static func map(_ dto: DroneModelDTO) -> DroneModel {
        DroneModel(
            id: dto.id,
            brand: dto.brand,
            model: dto.model,
            category: dto.category,
            weightGrams: dto.weightGrams,
            maxFlightTimeMinutes: dto.maxFlightTimeMinutes,
            cameraSpecs: dto.cameraSpecs,
            rangeMeters: dto.rangeMeters,
            imageURL: dto.imageURL.flatMap(URL.init(string:))
        )
    }
}
