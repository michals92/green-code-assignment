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

    override func loadView() {
        super.loadView()
        setLayout()
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
    }
}

extension RecordsListViewController: RecordsListViewControllerInput {

}
