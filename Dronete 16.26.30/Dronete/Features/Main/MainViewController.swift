//
//  MainViewController.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 30/1/24.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate {

    // MARK: - Properties
    private var viewModel = MainViewModel()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - IBOutlets
    @IBOutlet weak var cvMainCollectionView: UICollectionView!
    @IBOutlet weak var favoritesButton: UITabBarItem!
    @IBOutlet weak var moreButton: UITabBarItem!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradientBackground()
        navigationItem.backButtonTitle = "Volver"
        setupCollectionView()
        setupViewModel()
        loadingIndicator.center = view.center
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        viewModel.fetchData()
    }

    private func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemPurple.cgColor,
            UIColor.systemIndigo.cgColor,
            UIColor.systemTeal.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds

        let backgroundView = UIView(frame: view.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        view.insertSubview(backgroundView, at: 0)
    }

    private func setupCollectionView() {
        cvMainCollectionView.delegate = self
        cvMainCollectionView.dataSource = self
        cvMainCollectionView.backgroundColor = .clear
        if let layout = cvMainCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
            layout.minimumInteritemSpacing = 4
            layout.minimumLineSpacing = 8
        }
        registerCollectionViewCell()
    }

    private func registerCollectionViewCell() {
        let uiNib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        cvMainCollectionView.register(uiNib, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }

    private func setupViewModel() {
        viewModel.didUpdateData = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                self?.cvMainCollectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let manufacturer = viewModel.manufacturer(at: indexPath.item),
              let drones = viewModel.dronesByManufacturer[manufacturer] else { return }

        let droneListVC = DroneListViewController(nibName: "DroneListViewController", bundle: nil)
        droneListVC.viewModel = DroneListViewModel(brand: manufacturer, drones: drones)

        let transition = CATransition()
        transition.duration = 0.35
        transition.type = .fade
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(droneListVC, animated: false)
    }
}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfManufacturers()
    }
    
    func collectionView(
            _ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mainCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MainCollectionViewCell.identifier,
                    for: indexPath)
        let viewModelManufacturer = viewModel.manufacturer(at: indexPath.item)
        guard let cell = mainCell as? MainCollectionViewCell,
              let manufacturer = viewModelManufacturer else { return UICollectionViewCell() }
        
        cell.ivImage.image = viewModel.imageForManufacturer(at: indexPath.item)
        cell.lbTitle.text = manufacturer
        return cell
    }
}
