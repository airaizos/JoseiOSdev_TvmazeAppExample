//
//  CatalogueViewCell.swift
//  TVMaze_App_Example
//
//  Created by Adrian Iraizos Mendoza on 1/5/24.
//

import UIKit

final class CatalogueViewCell: UITableViewCell {

    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageLabel.layer.cornerRadius = 10
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        imageLabel.image = nil
        titleLabel.text = nil
        ratingLabel.text = nil
        genresLabel.text = nil
    }
}

