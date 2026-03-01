//
//  PlaceholderViewController.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

import UIKit

final class PlaceholderViewController: UIViewController {
    private let screenTitle: String

    init(screenTitle: String) {
        self.screenTitle = screenTitle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) no soportado. Usa init(screenTitle:)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = screenTitle
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
