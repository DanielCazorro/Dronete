//
//  DroneModel.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 29/4/24.
//

import Foundation

struct Drone: Codable {
    let manufacturer, name: String
    let uasClass: UasClass
    let weight, maxTakeoff, endurance: String
    let hasCamera, isToy: Bool?

    enum CodingKeys: String, CodingKey {
        case manufacturer, name
        case uasClass = "uas_class"
        case weight
        case maxTakeoff = "max_takeoff"
        case endurance
        case hasCamera = "has_camera"
        case isToy = "is_toy"
    }
}

enum UasClass: String, Codable {
    case c0 = "C0"
    case c1 = "C1"
    case c2 = "C2"
    case c3 = "C3"
    case c6 = "C6"
    case none = "none"
}

typealias Drones = [Drone]
