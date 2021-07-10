//
//  MovieListViewController.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import UIKit

class MovieListViewController: UITableViewController {

    var viewModel: MovieListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerNib()
    }
    
    private func registerNib() {
        let itemCellNib = UINib(nibName: self.viewModel.cellIdentifier, bundle: nil)
        self.tableView.register(itemCellNib, forCellReuseIdentifier: self.viewModel.cellIdentifier)
    }
}

//MARK: - UITableViewDelegate and DataSource

extension MovieListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.viewModel.cellIdentifier, for: indexPath) as! ItemTableViewCell
        cell.bind(cellViewModel: self.viewModel.movies[indexPath.row])
        return cell
    }
}
