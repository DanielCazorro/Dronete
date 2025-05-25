//
//  DroneListViewModel.swift
//  Dronete
//
//  Created by Daniel Cazorro on 25/5/25.
//

import Foundation

final class DroneListViewModel {
    let brand: String
    let drones: [Drone]

    init(brand: String, drones: [Drone]) {
        self.brand = brand
        self.drones = drones
    }

    func drone(at index: Int) -> Drone? {
        guard index >= 0 && index < drones.count else { return nil }
        return drones[index]
    }

    func numberOfDrones() -> Int {
        return drones.count
    }
}
