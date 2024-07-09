//
//  MainViewModel.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 29/4/24.
//

import UIKit

class MainViewModel {
    
    // MARK: - Properties
    private var manufacturers: [String] = []
    private var items: [Item] = []
    private let dataManager: MainViewDataManager
    var didUpdateData: (() -> Void)?
    
    // MARK: - Init
    init(dataManager: MainViewDataManager = MainViewDataManager()) {
        self.dataManager = dataManager
    }
    
    // MARK: - Methods
    func fetchData() {
        // Llamamos al método fetchData del DataManager para obtener los datos de la API
        dataManager.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let drones):
                // Actualizamos el estado interno con los datos obtenidos
                self.items = drones.map { Item(imageName: $0.manufacturer, title: $0.name) }
                // Actualizamos el estado interno con los datos obtenidos del array de Marcas
                self.manufacturers = Array(Set(self.items.map { $0.imageName })).sorted()
                // Notificamos a la vista
                self.didUpdateData?()
                // Imprimimos los datos obtenidos en la consola
                print("Datos de la API:")
                self.items.forEach { item in
                    print(item)
                }
            case .failure(let error):
                // Manejamos el error, como imprimirlo en la consola por ahora
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func numberOfItems() -> Int {
        return manufacturers.count
    }
    
    // FIXME: Borrar si no se usan
    func item(at index: Int) -> Item? {
        guard index >= 0 && index < items.count else {
            return nil
        }
        return items[index]
    }
    
    func manufacturer(at index: Int) -> String? {
        guard index >= 0 && index < manufacturers.count else {
            return nil
        }
        return manufacturers[index]
    }
    
    func imageForItem(at index: Int) -> UIImage? {
        guard let item = item(at: index) else {
            return nil
        }
        if let image = UIImage(named: item.imageName) {
            return image
        } else {
            return UIImage(systemName: "paperplane.fill")
        }
    }
}
