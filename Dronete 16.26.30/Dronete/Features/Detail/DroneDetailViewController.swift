//
//  DroneDetailViewController.swift
//  Dronete
//
//  Created by Daniel Cazorro on 24/5/25.
//

import UIKit

class DroneDetailViewController: UIViewController {

    private var gradientLayer: CAGradientLayer?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var takeoffLabel: UILabel!
    @IBOutlet weak var enduranceLabel: UILabel!
    @IBOutlet weak var hasCameraLabel: UILabel!
    @IBOutlet weak var isToyLabel: UILabel!

    var viewModel: DroneDetailViewModel!

    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalles del Dron"
        applyGradientBackground()
        applySettingsIfNeeded()
        setupLoadingIndicator()
        configureView()
    }

    private func applyGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds

        if traitCollection.userInterfaceStyle == .dark {
            gradient.colors = [
                UIColor.black.cgColor,
                UIColor.darkGray.cgColor
            ]
        } else {
            gradient.colors = [
                UIColor.systemIndigo.cgColor,
                UIColor.systemBlue.cgColor,
                UIColor.systemTeal.cgColor
            ]
        }

        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
        self.gradientLayer = gradient
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            gradientLayer?.removeFromSuperlayer()
            applyGradientBackground()
        }
    }
    
    private func applySettingsIfNeeded() {
        // Aquí se aplicarán preferencias de usuario desde UserDefaults (ej: modo oscuro)
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.center = view.center
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }
    
    private func setupStackViewConstraints(_ stackView: UIStackView) {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func configureView() {
        nameLabel.text = viewModel.droneName
        manufacturerLabel.text = viewModel.manufacturer
        classLabel.text = viewModel.uasClass
        weightLabel.text = viewModel.weight
        takeoffLabel.text = viewModel.takeoff
        enduranceLabel.text = viewModel.endurance
        hasCameraLabel.text = viewModel.hasCamera
        isToyLabel.text = viewModel.isToy

        let values: [(UILabel, String)] = [
            (nameLabel, "Nombre del dron"),
            (manufacturerLabel, "Fabricante"),
            (classLabel, "Clase UAS"),
            (weightLabel, "Peso"),
            (takeoffLabel, "Peso máximo despegue"),
            (enduranceLabel, "Autonomía"),
            (hasCameraLabel, "¿Tiene cámara?"),
            (isToyLabel, "¿Es un dron de juguete?")
        ]

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        setupStackViewConstraints(stackView)

        values.forEach { (label, title) in
            let container = UIStackView()
            container.axis = .vertical
            container.spacing = 4
            container.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            container.layer.cornerRadius = 10
            container.isLayoutMarginsRelativeArrangement = true
            container.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)

            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = .white
            titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)

            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            label.textAlignment = .center
            label.numberOfLines = 0

            container.addArrangedSubview(titleLabel)
            container.addArrangedSubview(label)
            stackView.addArrangedSubview(container)
        }

        loadingIndicator.stopAnimating()
    }
}
