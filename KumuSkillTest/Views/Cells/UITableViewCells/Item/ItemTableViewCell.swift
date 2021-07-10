//
//  ItemTableViewCell.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import UIKit
import Kingfisher

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(cellViewModel: BaseCellViewModel) {
        guard let itemCellViewModel = cellViewModel as? ItemTableViewCellModel else { return }
        
        self.artworkImageView.kf.setImage(with: itemCellViewModel.artworkImageUrl, placeholder: UIImage(named: "placeholder"), options: nil, completionHandler: nil)
        self.trackNameLabel.text = itemCellViewModel.title
        self.priceLabel.text = itemCellViewModel.formattedPrice
        self.genreLabel.text = itemCellViewModel.genre
    }
}
