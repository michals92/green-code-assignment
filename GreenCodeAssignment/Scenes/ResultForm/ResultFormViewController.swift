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
    private let dataSource = ResultFormTableViewDataSource()

    private var bottomConstraint: NSLayoutConstraint?

    override func loadView() {
        super.loadView()
        setLayout()
        registerKeyboardNotifications()

        title = "ResultForm.title".localized

        tableView.register(ResultFormTableViewCell.self, forCellReuseIdentifier: String(describing: ResultFormTableViewCell.self))
        tableView.dataSource = dataSource
        tableView.allowsSelection = false
        tableView.separatorStyle = .none

        bottomConstraint = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint?.isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        viewModel?.viewDidLoad()
    }

    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setLayout() {
        view.backgroundColor = .systemBackground

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
        let confirmBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(confirmButtonClicked))
        self.navigationItem.leftBarButtonItem = addBarButtonItem
        self.navigationItem.rightBarButtonItem = confirmBarButtonItem
    }

    @objc
    func keyboardWillShow(sender: NSNotification) {
        if let info = sender.userInfo, let keyboardFrameEndUserInfoKey = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardSize = keyboardFrameEndUserInfoKey.cgRectValue.height
            bottomConstraint?.constant = -keyboardSize
        }
    }

    @objc
    func keyboardWillHide(sender: NSNotification) {
        bottomConstraint?.constant = 0
    }

    @objc
    func cancelButtonClicked() {
        viewModel?.cancel()
    }

    @objc
    private func confirmButtonClicked() {
        viewModel?.confirm()
    }
}

extension ResultFormViewController: ResultFormViewControllerInput {
    func reloadData(cellModels: [ResultFormTableViewCellModel]) {
        dataSource.cellModels = cellModels
        tableView.reloadData()
    }
}
