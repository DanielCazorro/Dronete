//
//  FavoritesManager.swift
//  Dronete
//
//  Created by Daniel Cazorro on 25/5/25.
//

import Foundation
import CoreData
import UIKit

final class FavoritesManager {

    static let shared = FavoritesManager()

    private let context: NSManagedObjectContext

    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access AppDelegate")
        }
        self.context = appDelegate.persistentContainer.viewContext
    }

    func addToFavorites(drone: Drone) {
        guard !isFavorite(drone: drone) else { return }

        let favorite = FavoriteDrone(context: context)
        favorite.id = "\(drone.manufacturer)-\(drone.name)"
        favorite.name = drone.name
        favorite.manufacturer = drone.manufacturer
        favorite.uasClass = drone.uasClass.rawValue
        favorite.hasCamera = drone.hasCamera ?? false
        favorite.isToy = drone.isToy ?? false

        saveContext()
    }

    func removeFromFavorites(drone: Drone) {
        let id = "\(drone.manufacturer)-\(drone.name)"
        let request: NSFetchRequest<FavoriteDrone> = FavoriteDrone.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)

        if let result = try? context.fetch(request), let objectToDelete = result.first {
            context.delete(objectToDelete)
            saveContext()
        }
    }

    func isFavorite(drone: Drone) -> Bool {
        let id = "\(drone.manufacturer)-\(drone.name)"
        let request: NSFetchRequest<FavoriteDrone> = FavoriteDrone.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)

        if let result = try? context.fetch(request) {
            return !result.isEmpty
        }

        return false
    }

    func fetchFavorites() -> [FavoriteDrone] {
        let request: NSFetchRequest<FavoriteDrone> = FavoriteDrone.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving favorites: \(error)")
        }
    }
}
