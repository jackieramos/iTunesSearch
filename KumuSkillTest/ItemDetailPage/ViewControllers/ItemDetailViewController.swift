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
        self.bindData()
    }
    
    ///Bind ViewModel
    private func bindData() {
        self.viewModel.item
            .asObservable()
            .subscribe(onNext: { [unowned self] _ in
                DispatchQueue.main.async {
                    self.setupUI()
                }
            })
            .disposed(by: self.viewModel.disposeBag)
    }
    
    ///Setup UI
    private func setupUI() {
        guard let itemViewModel = self.viewModel.item else { return }

        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: itemViewModel.value.item.isFavorite ? "star.fill" : "star")
        self.artworkImageView.kf.setImage(with: itemViewModel.value.artworkUrl, placeholder: itemViewModel.value.placeholderImage, options: nil, completionHandler: nil)
        self.nameLabel.text = itemViewModel.value.title
        self.priceLabel.text = itemViewModel.value.subTitle
        self.genreLabel.text = itemViewModel.value.item.genre
        self.longDescriptionLabel.text = itemViewModel.value.item.longDescription
    }
    
    ///Mark item as favorite
    @IBAction func didClickFavoriteButton(_ sender: Any) {
        guard let itemViewModel = self.viewModel.item else { return }
        
        let isFavorite = itemViewModel.value.item.isFavorite ? false : true
        self.viewModel.markItem(with: itemViewModel.value.item.trackId, asFavorite: isFavorite)
    }
}
