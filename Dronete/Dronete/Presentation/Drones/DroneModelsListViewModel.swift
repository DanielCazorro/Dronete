//
//  DroneModelsListViewModel.swift
//  Dronete
//
//  Created by Daniel Cazorro on 16/3/26.
//

import Foundation

@MainActor
final class DroneModelsListViewModel {
    enum State { case idle, loading, loaded, error(String) }

    private let getDroneModelsUseCase: GetDroneModelsUseCase
    private var allItems: [DroneModel] = []
    private(set) var visibleItems: [DroneModel] = []
    var onStateChange: ((State) -> Void)?

    init(getDroneModelsUseCase: GetDroneModelsUseCase) {
        self.getDroneModelsUseCase = getDroneModelsUseCase
    }

    func load(forceRefresh: Bool = false) async {
        onStateChange?(.loading)
        do {
            allItems = try await getDroneModelsUseCase.execute(forceRefresh: forceRefresh)
            visibleItems = allItems
            onStateChange?(.loaded)
        } catch {
            onStateChange?(.error("No se pudieron cargar los modelos"))
        }
    }

    func updateSearch(query: String) {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else {
            visibleItems = allItems
            onStateChange?(.loaded)
            return
        }

        visibleItems = allItems.filter {
            $0.brand.lowercased().contains(q)
            || $0.model.lowercased().contains(q)
            || $0.category.lowercased().contains(q)
        }
        onStateChange?(.loaded)
    }
}
