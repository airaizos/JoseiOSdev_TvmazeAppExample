//
//  ShowCatalogueTableViewCell.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 21/03/24.
//

import UIKit

class ShowCatalogueTableViewCell: UITableViewCell {
    @IBOutlet weak var imgRow: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgShow: UIImageView!
    
    weak var presenter:PresenterProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(show:ShowModel?, indexPath:IndexPath, presenter:PresenterProtocol?) {
        self.presenter = presenter
        self.tag = indexPath.row
        
        self.imgShow.imageFromUrl(urlString: show?.image?.medium ?? "", force: false, placeholder: nil)
        self.lblName.text = show?.name ?? ""
        
        let image = UIImage(named: "rightRow")?.withRenderingMode(.alwaysTemplate)
        if #available(iOS 13.0, *) {
            self.imgRow.tintColor = .systemGray
        }
        self.imgRow.image = image
        
    }
    
}
