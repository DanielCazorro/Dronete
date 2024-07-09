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
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        ivImage.image = nil
        lbTitle.text = ""
    }
}
