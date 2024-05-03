//
//  FavoriteViewCell.swift
//  TVMaze_App_Example
//
//  Created by Adrian Iraizos Mendoza on 2/5/24.
//

import UIKit

final class FavoriteViewCell: UITableViewCell {
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageLabel.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        imageLabel.image = nil
        titlelabel.text = nil
        ratingLabel.text = nil
    }
}
