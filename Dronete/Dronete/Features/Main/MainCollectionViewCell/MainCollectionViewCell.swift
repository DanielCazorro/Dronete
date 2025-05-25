//
//  MainCollectionViewCell.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 29/4/24.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCollectionViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        
        ivImage.tintColor = .white
        ivImage.contentMode = .scaleAspectFit
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        ivImage.image = nil
        lbTitle.text = .empty
    }
    
    func configure(with manufacturer: String) {
        lbTitle.text = manufacturer
        let icons = [
            "paperplane.fill",
            "airplane",
            "bolt.horizontal.fill",
            "antenna.radiowaves.left.and.right",
            "location.north.line"]
        let index = abs(manufacturer.hashValue) % icons.count
        let iconName = icons[index]
        ivImage.image = UIImage(systemName: iconName)
    }
}
