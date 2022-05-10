//
//  RecordsListViewController.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

class RecordsListViewController: UIViewController {
    private let tableView = UITableView()

    var viewModel: RecordsListViewModelInput?
    let dataSource = RecordListTableViewDataSource()

    override func loadView() {
        super.loadView()
        setLayout()
        title = "Výsledky"

        tableView.register(RecordsListTableViewCell.self, forCellReuseIdentifier: String(describing: RecordsListTableViewCell.self))
        tableView.dataSource = dataSource
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.viewDidLoad()
    }

    func setLayout() {
        view.backgroundColor = .systemBackground

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
    }

    func reloadData(results: [SportResult]) {
        dataSource.results = results
        tableView.reloadData()
    }

    @objc func addButtonClicked() {
        viewModel?.showResultForm()
    }
}

extension RecordsListViewController: RecordsListViewControllerInput {

}
