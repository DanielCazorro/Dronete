//
//  NewsListViewModel.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

import Foundation

@MainActor
final class NewsListViewModel {
    enum State {
        case idle
        case loading
        case loaded
        case error(String)
    }

    private let getNewsUseCase: GetNewsUseCase
    private(set) var items: [News] = []
    var onStateChanges: ((State) -> Void)?

    init(getNewsUseCase: GetNewsUseCase) {
        self.getNewsUseCase = getNewsUseCase
    }

    func load(forceRefresh: Bool = false) async {
        onStateChanges?(.loading)
        do {
            items = try await getNewsUseCase.execute(forceRefresh: forceRefresh)
            onStateChanges?(.loaded)
        } catch {
            onStateChanges?(.error("No se pudieron cargar las noticias"))
        }
    }
}
