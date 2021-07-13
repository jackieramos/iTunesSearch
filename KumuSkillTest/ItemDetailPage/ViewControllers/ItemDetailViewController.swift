//
//  ItemDetailViewController.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import UIKit
import Kingfisher

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var lastVisitedContainerView: UIView!
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
        self.viewModel.saveLastState()
    }
    
    ///Bind ViewModel - observe changes on viewModel.item
    private func bindData() {
        self.viewModel.item
            .asObservable()
            .subscribe(onNext: { [unowned self] _ in
                DispatchQueue.main.async {
                    self.setupItemDetails()
                }
            })
            .disposed(by: self.viewModel.disposeBag)
    }
    
    ///Setup UI
    private func setupUI() {
        //Add last visited view for showing last visited label
        let lastVisitedView: LastVisitedView = LastVisitedView.fromNib()
        lastVisitedView.bind(self.viewModel.pageState?.lastVisitedDate ?? "")
        self.lastVisitedContainerView.addSubview(lastVisitedView)
        
        lastVisitedView.translatesAutoresizingMaskIntoConstraints = false
        lastVisitedView.topAnchor.constraint(equalTo: self.lastVisitedContainerView.topAnchor, constant: 0).isActive = true
        lastVisitedView.bottomAnchor.constraint(equalTo: self.lastVisitedContainerView.bottomAnchor, constant: 0).isActive = true
        lastVisitedView.leadingAnchor.constraint(equalTo: self.lastVisitedContainerView.leadingAnchor, constant: 0).isActive = true
        lastVisitedView.trailingAnchor.constraint(equalTo: self.lastVisitedContainerView.trailingAnchor, constant: 0).isActive = true
        
        self.setupItemDetails()
    }
    
    private func setupItemDetails() {
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
