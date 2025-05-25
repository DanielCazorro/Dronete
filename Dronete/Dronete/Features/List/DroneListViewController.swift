//
//  DroneListViewController.swift
//  Dronete
//
//  Created by Daniel Cazorro on 25/5/25.
//

import UIKit

class DroneListViewController: UIViewController {

    var viewModel: DroneListViewModel!
    private var collectionView: UICollectionView!
    private var gradientLayer: CAGradientLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradientBackground()
        title = viewModel.brand
        navigationItem.backButtonTitle = "Volver"
        setupCollectionView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer?.frame = view.bounds
    }

    private func applyGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.systemIndigo.cgColor,
            UIColor.systemBlue.cgColor,
            UIColor.systemTeal.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = view.bounds
        gradient.zPosition = -1
        view.layer.insertSublayer(gradient, at: 0)
        self.gradientLayer = gradient
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: view.bounds.width - 40, height: 60)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DroneCell")

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DroneListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.drones.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let drone = viewModel.drones[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DroneCell", for: indexPath)
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        cell.layer.cornerRadius = 8

        // Add label
        let label = UILabel(frame: cell.bounds.insetBy(dx: 12, dy: 8))
        label.text = drone.name
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white

        // Clean previous subviews to avoid duplicates
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.contentView.addSubview(label)

        return cell
    }
}

extension DroneListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDrone = viewModel.drones[indexPath.item]
        let detailVC = DroneDetailViewController(nibName: "DroneDetailViewController", bundle: nil)
        detailVC.viewModel = DroneDetailViewModel(drone: selectedDrone)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
