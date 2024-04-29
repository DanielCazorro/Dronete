//
//  MainViewModel.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 29/4/24.
//

import UIKit

class MainViewModel {
    
    // MARK: - Properties
    private var items: [Item] = []
    
    // MARK: - Methods
    func fetchData() {
        // Aquí puedes llamar a tu MainViewDataManager o MainViewApiClient para obtener los datos
        // En este ejemplo, simplemente inicializaremos los datos mockeados
        items = [
            Item(imageName: "drone_icon", title: "Drones"),
            Item(imageName: "brand_icon", title: "Marcas")
        ]
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func item(at index: Int) -> Item? {
        guard index >= 0 && index < items.count else {
            return nil
        }
        return items[index]
    }
    
    func imageForItem(at index: Int) -> UIImage? {
        guard let item = item(at: index) else {
            return nil
        }
        if let image = UIImage(named: item.imageName) {
            return image
        } else {
            return UIImage(systemName: "questionmark.square.fill")
        }
    }
}
