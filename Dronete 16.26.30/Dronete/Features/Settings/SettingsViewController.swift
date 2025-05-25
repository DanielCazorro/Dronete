//
//  SettingsViewController.swift
//  Dronete
//
//  Created by Daniel Cazorro on 25/5/25.
//

import UIKit

class SettingsViewController: UIViewController {

    private var gradientLayer: CAGradientLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ajustes"
        applyGradientBackground()
        setupIllustration()
    }

    private func applyGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.systemPurple.cgColor,
            UIColor.systemBlue.cgColor,
            UIColor.systemTeal.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
        self.gradientLayer = gradient
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer?.frame = view.bounds
    }

    private func setupIllustration() {
        let imageView = UIImageView(image: UIImage(systemName: "gearshape.fill"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "Próximamente: Ajustes"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(label)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
