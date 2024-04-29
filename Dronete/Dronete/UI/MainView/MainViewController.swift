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
    private var drones: [Drone] = []

    // MARK: - IBOutlets
    @IBOutlet weak var cvMainCollectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchDataFromAPI()
        
        viewModel.fetchData()
    }
    
    private func fetchDataFromAPI() {
        guard let url = URL(string: "https://github.com/dronetag/opendronelist/releases/download/20230904-2037/models.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(Drones.self, from: data)
                DispatchQueue.main.async {
                    self.drones = decodedData
                    // Aquí puedes imprimir los datos por consola
                    print("Datos de la API:")
                    self.drones.forEach { drone in
                        print(drone)
                    }
                    self.updateUI()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
        
    private func updateUI() {
        // Aquí puedes actualizar la interfaz de usuario con los datos de los drones
        // Por ejemplo, podrías recargar una tabla o actualizar vistas según tus necesidades.
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
