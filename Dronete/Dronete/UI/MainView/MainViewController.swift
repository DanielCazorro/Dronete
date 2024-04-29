//
//  MainViewController.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 30/1/24.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var cvMainCollectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerCollectionViewCell()
    }
    
    private func setupCollectionView() {
        cvMainCollectionView.delegate = self
        cvMainCollectionView.dataSource = self
    }
    
    private func registerCollectionViewCell() {
        cvMainCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }

}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.item]
        cell.ivImage.image = UIImage(named: item.imageName)
        cell.lbTitle.text = item.title
        
        return cell
    }
}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
}

struct Item {
    let imageName: String
    let title: String
}

private let items: [Item] = [
    Item(imageName: "drone_icon", title: "Drones"),
    Item(imageName: "brand_icon", title: "Marcas"),
    Item(imageName: "photo", title: "Item 1"),
    Item(imageName: "doc", title: "Item 2"),
    Item(imageName: "paperclip", title: "Item 3"),
    Item(imageName: "folder", title: "Item 4"),
    Item(imageName: "bookmark", title: "Item 5"),
    Item(imageName: "envelope", title: "Item 6"),
    Item(imageName: "phone", title: "Item 7"),
    Item(imageName: "flag", title: "Item 8"),
    Item(imageName: "heart", title: "Item 9"),
    Item(imageName: "star", title: "Item 10"),
    Item(imageName: "magnifyingglass", title: "Item 11"),
    Item(imageName: "cart", title: "Item 12"),
    Item(imageName: "pencil", title: "Item 13"),
    Item(imageName: "scissors", title: "Item 14"),
    Item(imageName: "gear", title: "Item 15"),
    Item(imageName: "hammer", title: "Item 16"),
    Item(imageName: "wand.and.stars", title: "Item 17"),
    Item(imageName: "bolt.horizontal", title: "Item 18"),
    Item(imageName: "gift", title: "Item 19"),
    Item(imageName: "bell", title: "Item 20")
]
