//
//  ResultFormViewController.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

class ResultFormViewController: UIViewController {
    private let tableView = UITableView()

    var viewModel: ResultFormViewModelInput?
    let dataSource = ResultFormTableViewDataSource()

    override func loadView() {
        super.loadView()
        setLayout()
        title = "ResultForm.title".localized

        tableView.register(ResultFormTableViewCell.self, forCellReuseIdentifier: String(describing: ResultFormTableViewCell.self))
        tableView.dataSource = dataSource
        tableView.allowsSelection = false
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

        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
        let confirmBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(confirmButtonClicked))
        self.navigationItem.leftBarButtonItem = addBarButtonItem
        self.navigationItem.rightBarButtonItem = confirmBarButtonItem
    }

    @objc func cancelButtonClicked() {
        viewModel?.cancel()
    }

    @objc func confirmButtonClicked() {
        viewModel?.confirm()
    }
}

extension ResultFormViewController: ResultFormViewControllerInput {
    
}
