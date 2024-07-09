//
//  MainViewController.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 30/1/24.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = MainViewModel()

    // MARK: - IBOutlets
    @IBOutlet weak var cvMainCollectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViewModel()
        viewModel.fetchData()
    }
    
    private func setupCollectionView() {
        cvMainCollectionView.delegate = self
        cvMainCollectionView.dataSource = self
        registerCollectionViewCell()
    }
    
    private func registerCollectionViewCell() {
        cvMainCollectionView.register(UINib(nibName: "MainCollectionViewCell",
                                            bundle: nil),
                                            forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    private func setupViewModel() {
        viewModel.didUpdateData = { [weak self] in
            DispatchQueue.main.async {
                self?.cvMainCollectionView.reloadData()
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier,
                                                            for: indexPath) as? MainCollectionViewCell,
              let manufacturer = viewModel.manufacturer(at: indexPath.item)
        else { return UICollectionViewCell() }
        
        cell.ivImage.image = viewModel.imageForItem(at: indexPath.item)
        cell.lbTitle.text = manufacturer
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {}
