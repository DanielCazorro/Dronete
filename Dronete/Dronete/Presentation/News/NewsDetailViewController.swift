//
//  NewsDetailViewController.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

import UIKit

final class NewsDetailViewController: UIViewController {
    private let news: News

    init(news: News) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) no soportado")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Detalle"

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = news.title
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        let sourceLabel = UILabel()
        sourceLabel.text = "Fuente: \(news.source)"
        sourceLabel.textColor = .secondaryLabel

        let descriptionLabel = UILabel()
        descriptionLabel.text = news.description
        descriptionLabel.numberOfLines = 0

        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(sourceLabel)
        stack.addArrangedSubview(descriptionLabel)

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
