//
//  DroneDetailViewController.swift
//  Dronete
//
//  Created by Daniel Cazorro on 24/5/25.
//

import UIKit

class DroneDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var takeoffLabel: UILabel!
    @IBOutlet weak var enduranceLabel: UILabel!
    @IBOutlet weak var hasCameraLabel: UILabel!
    @IBOutlet weak var isToyLabel: UILabel!

    var viewModel: DroneDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        nameLabel.text = viewModel.title
        manufacturerLabel.text = viewModel.manufacturer
        classLabel.text = viewModel.uasClass
        weightLabel.text = viewModel.weight
        takeoffLabel.text = viewModel.takeoff
        enduranceLabel.text = viewModel.endurance
        hasCameraLabel.text = viewModel.hasCamera
        isToyLabel.text = viewModel.isToy
    }
}
