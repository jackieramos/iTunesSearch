//
//  MovieListViewController.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
    var viewModel: MovieListViewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.searchItems(term: "star", countryCode: "AU", media: "movie")
        
        self.registerNib()
        self.bindData()
    }
    
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
    
    private func registerNib() {
        let itemCellNib = UINib(nibName: self.viewModel.cellIdentifier, bundle: nil)
        self.moviesTableView.register(itemCellNib, forCellReuseIdentifier: self.viewModel.cellIdentifier)
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
