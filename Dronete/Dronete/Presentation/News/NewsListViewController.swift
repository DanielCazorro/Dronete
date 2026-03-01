//
//  NewsListViewController.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

import UIKit

final class NewsListViewController: UIViewController {
    private let viewModel: NewsListViewModel
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let refreshControl = UIRefreshControl()

    init(viewModel: NewsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coer:) no soportado")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Noticias"
        view.backgroundColor = .systemBackground
        setupTable()
        bindViewModel()

        Task { await viewModel.load() }
    }

    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NewsCell")

        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onStateChanges = { [weak self] state in
            guard let self else { return }
            switch state {
                case .idle:
                    break
                case .loading:
                    break
                case .loaded:
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                case .error(let message):
                    self.refreshControl.endRefreshing()
                    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
            }
        }
    }

    @objc private func didPullToRefresh() {
        Task { await viewModel.load(forceRefresh: true)}
    }
}

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = item.title
        config.secondaryText = item.source
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.row]
        let detailVC = NewsDetailViewController(news: item)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
