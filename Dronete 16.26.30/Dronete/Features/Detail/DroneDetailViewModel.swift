//
//  DroneDetailViewModel.swift
//  Dronete
//
//  Created by Daniel Cazorro on 24/5/25.
//

import Foundation

class DroneDetailViewModel {
    private let drone: Drone

    init(drone: Drone) {
        self.drone = drone
    }

    var title: String { drone.name }
    var manufacturer: String { drone.manufacturer }
    var uasClass: String { drone.uasClass.rawValue }
    var weight: String { drone.weight }
    var takeoff: String { drone.maxTakeoff }
    var endurance: String { drone.endurance }
    var hasCamera: String { drone.hasCamera == true ? "Sí" : "No" }
    var isToy: String { drone.isToy == true ? "Sí" : "No" }
}
