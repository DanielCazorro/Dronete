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

        let darkModeLabel = UILabel()
        darkModeLabel.text = "Modo oscuro"
        darkModeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        darkModeLabel.textColor = .white
        darkModeLabel.translatesAutoresizingMaskIntoConstraints = false

        let darkModeSwitch = UISwitch()
        darkModeSwitch.isOn = AppSettings.isDarkModeEnabled
        darkModeSwitch.onTintColor = .systemPurple
        darkModeSwitch.translatesAutoresizingMaskIntoConstraints = false
        darkModeSwitch.addTarget(self, action: #selector(darkModeSwitchChanged(_:)), for: .valueChanged)

        view.addSubview(darkModeLabel)
        view.addSubview(darkModeSwitch)

        NSLayoutConstraint.activate([
            darkModeLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            darkModeLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -70),

            darkModeSwitch.centerYAnchor.constraint(equalTo: darkModeLabel.centerYAnchor),
            darkModeSwitch.leadingAnchor.constraint(equalTo: darkModeLabel.trailingAnchor, constant: 16)
        ])
    }

    @objc private func darkModeSwitchChanged(_ sender: UISwitch) {
        AppSettings.isDarkModeEnabled = sender.isOn
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window else { return }
        window.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
    }
}
