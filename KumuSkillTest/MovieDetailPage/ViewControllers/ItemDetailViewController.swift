//
//  ItemDetailViewController.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import UIKit
import Kingfisher

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var viewModel: ItemDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        guard let item = self.viewModel.item else { return }

        self.artworkImageView.kf.setImage(with: item.artworkImageUrl, placeholder: item.placeholderImage, options: nil, completionHandler: nil)
        self.nameLabel.text = item.title
        self.priceLabel.text = item.subTitle
        self.genreLabel.text = item.genre
        self.longDescriptionLabel.text = item.longDescription
    }
    
    @IBAction func didClickFavoriteButton(_ sender: Any) {
        print("Add to Fav")
    }
}
