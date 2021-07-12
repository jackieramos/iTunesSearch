//
//  ItemListViewController.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import UIKit

class ItemListViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
    lazy var searchBar: UISearchBar = UISearchBar()
    
    var viewModel: ItemListViewModel = ItemListViewModel()
    
    var timer: Timer?
    
    //MARK: - VC life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.registerNib()
        self.bindData()
        self.viewModel.getItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.timer?.invalidate()
    }
    
    //MARK: - Methods
    
    ///Setup UI of Movies List Page
    private func setupUI() {
        self.searchBar.searchBarStyle = UISearchBar.Style.default
        self.searchBar.placeholder = "Search item"
        self.searchBar.sizeToFit()
        self.searchBar.isTranslucent = false
        self.searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    ///Data binding
    private func bindData() {
        self.viewModel.movies
            .asObservable()
            .subscribe(onNext: { [unowned self] _ in
                DispatchQueue.main.async {
                    self.moviesTableView.reloadData()
                }
            })
            .disposed(by: self.viewModel.disposeBag)
    }
    
    ///Register ItemTableViewCell nib to tableView
    private func registerNib() {
        let itemCellNib = UINib(nibName: self.viewModel.cellIdentifier, bundle: nil)
        self.moviesTableView.register(itemCellNib, forCellReuseIdentifier: self.viewModel.cellIdentifier)
    }

    //MARK: - Actions
    
    @objc private func performSearch(_ timer: Timer) {
        if let term = timer.userInfo as? String {
            self.viewModel.searchItems(term: term, countryCode: "AU", media: "movie")
        }
    }
}

//MARK: - UITableViewDelegate and DataSource

extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movies.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.viewModel.cellIdentifier, for: indexPath) as! BaseTableViewCell
        cell.bind(cellViewModel: self.viewModel.movies.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemDetailVc = ItemDetailViewController.instantiate(fromAppStoryboard: .main)
        itemDetailVc.viewModel =  ItemDetailViewModel(item: self.viewModel.movies.value[indexPath.row])
        self.navigationController?.pushViewController(itemDetailVc, animated: true)
    }
}

//MARK: - UISearchBarDelegate

extension ItemListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(performSearch(_:)), userInfo: searchText, repeats: false)
    }
}
