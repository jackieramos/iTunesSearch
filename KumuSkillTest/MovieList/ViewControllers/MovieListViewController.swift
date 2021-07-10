//
//  MovieListViewController.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
    lazy var searchBar: UISearchBar = UISearchBar()
    
    var viewModel: MovieListViewModel = MovieListViewModel()
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.registerNib()
        self.bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.timer?.invalidate()
    }
    
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

    @objc private func performSearch(_ timer: Timer) {
        if let term = timer.userInfo as? String {
            self.viewModel.searchItems(term: term, countryCode: "AU", media: "movie")
        }
    }
}

//MARK: - UITableViewDelegate and DataSource

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movies.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.viewModel.cellIdentifier, for: indexPath) as! ItemTableViewCell
        cell.bind(cellViewModel: self.viewModel.movies.value[indexPath.row])
        return cell
    }
}

//MARK: - UISearchBarDelegate

extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(performSearch(_:)), userInfo: searchText, repeats: false)
    }
}
