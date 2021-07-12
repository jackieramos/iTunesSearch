//
//  FavoritesListViewController.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/12/21.
//

import UIKit

class FavoritesListViewController: UIViewController {

    @IBOutlet weak var lastVisitedContainerView: UIView!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    var viewModel: FavoritesListViewModel = FavoritesListViewModel()
    
    //MARK: - VC life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.registerNib()
        self.bindData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.getFavoriteItems()
    }
    
    private func setupUI() {
        let lastVisitedView: LastVisitedView = LastVisitedView.fromNib()
        self.lastVisitedContainerView.addSubview(lastVisitedView)
        
        lastVisitedView.translatesAutoresizingMaskIntoConstraints = false
        lastVisitedView.topAnchor.constraint(equalTo: self.lastVisitedContainerView.topAnchor, constant: 0).isActive = true
        lastVisitedView.bottomAnchor.constraint(equalTo: self.lastVisitedContainerView.bottomAnchor, constant: 0).isActive = true
        lastVisitedView.leadingAnchor.constraint(equalTo: self.lastVisitedContainerView.leadingAnchor, constant: 0).isActive = true
        lastVisitedView.trailingAnchor.constraint(equalTo: self.lastVisitedContainerView.trailingAnchor, constant: 0).isActive = true
    }
    
    ///Data binding
    private func bindData() {
        self.viewModel.favoriteMovies
            .asObservable()
            .subscribe(onNext: { [unowned self] _ in
                DispatchQueue.main.async {
                    self.favoritesTableView.reloadData()
                }
            })
            .disposed(by: self.viewModel.disposeBag)
    }
    
    ///Register ItemTableViewCell nib to tableView
    private func registerNib() {
        let itemCellNib = UINib(nibName: self.viewModel.cellIdentifier, bundle: nil)
        self.favoritesTableView.register(itemCellNib, forCellReuseIdentifier: self.viewModel.cellIdentifier)
    }
}

//MARK: - UITableViewDelegate and DataSource

extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.favoriteMovies.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.viewModel.cellIdentifier, for: indexPath) as! BaseTableViewCell
        cell.bind(cellViewModel: self.viewModel.favoriteMovies.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemDetailVc = ItemDetailViewController.instantiate(fromAppStoryboard: .main)
        itemDetailVc.viewModel =  ItemDetailViewModel(item: self.viewModel.favoriteMovies.value[indexPath.row])
        self.navigationController?.pushViewController(itemDetailVc, animated: true)
    }
}
