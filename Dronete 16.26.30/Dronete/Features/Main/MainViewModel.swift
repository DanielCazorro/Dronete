//
//  MainViewModel.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 29/4/24.
//

import UIKit

class MainViewModel {
    private let repository: any DroneRepositoryProtocol
    private(set) var dronesByManufacturer: [String: [Drone]] = [:]
    var didUpdateData: (() -> Void)?

    init(repository: DroneRepositoryProtocol = DroneRepository()) {
        self.repository = repository
    }

    func fetchData() {
        repository.fetchDrones { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let drones):
                self.dronesByManufacturer = Dictionary(grouping: drones, by: { $0.manufacturer })
                self.didUpdateData?()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    func numberOfManufacturers() -> Int {
        dronesByManufacturer.keys.count
    }

    func manufacturer(at index: Int) -> String? {
        Array(dronesByManufacturer.keys.sorted())[safe: index]
    }

    func imageForManufacturer(at index: Int) -> UIImage? {
        guard let manufacturer = manufacturer(at: index) else {
            return nil
        }
        return UIImage(named: manufacturer) ?? UIImage(systemName: "paperplane.fill")
    }

    func droneCount(forManufacturer manufacturer: String) -> Int {
        return dronesByManufacturer[manufacturer]?.count ?? 0
    }
}
