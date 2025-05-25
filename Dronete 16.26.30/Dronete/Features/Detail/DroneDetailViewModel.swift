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

    var droneName: String { drone.name }
    var manufacturer: String { drone.manufacturer }

    var uasClass: String {
        drone.uasClass == .none ? "Desconocida" : drone.uasClass.rawValue
    }

    var weight: String { "\(drone.weight) g" }
    var takeoff: String { "\(drone.maxTakeoff) g" }
    var endurance: String { "\(drone.endurance) min" }

    var hasCamera: String { drone.hasCamera == true ? "Sí" : "No" }
    var isToy: String { drone.isToy == true ? "Sí" : "No" }
}
