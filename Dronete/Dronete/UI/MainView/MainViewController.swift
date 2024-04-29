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
        
        viewModel.fetchData()
    }
    
    private func setupCollectionView() {
        cvMainCollectionView.delegate = self
        cvMainCollectionView.dataSource = self
        registerCollectionViewCell()
    }
    
    private func registerCollectionViewCell() {
        cvMainCollectionView.register(UINib(
            nibName: "MainCollectionViewCell",
            bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let item = viewModel.item(at: indexPath.item) {
            cell.ivImage.image = viewModel.imageForItem(at: indexPath.item)
            cell.lbTitle.text = item.title
        }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {}
