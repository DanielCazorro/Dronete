//
//  AppDelegate.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 30/1/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(
            _ application: UIApplication,
            configurationForConnecting connectingSceneSession: UISceneSession,
            options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Dronete")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
            #if DEBUG
                fatalError("Unresolved Core Data error: \(error), \(error.userInfo)")
            #else
                print("⚠️ Core Data error: \(error), \(error.userInfo)")
            #endif
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                #if DEBUG
                    fatalError("Unresolved Core Data error: \(nsError), \(nsError.userInfo)")
                #else
                    print("⚠️ Core Data error: \(nsError), \(nsError.userInfo)")
                #endif
            }
        }
    }
}
