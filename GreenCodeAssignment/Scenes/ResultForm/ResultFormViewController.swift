//
//  ResultFormViewController.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

class ResultFormViewController: UIViewController {
    private let tableView = UITableView()
    private let applyButton = UIButton()
    private var stackView: UIStackView!

    var viewModel: ResultFormViewModelInput?
    let dataSource = ResultFormTableViewDataSource()

    var bottomConstraint: NSLayoutConstraint?

    override func loadView() {
        super.loadView()
        setLayout()
        registerKeyboardNotifications()

        title = "ResultForm.title".localized

        tableView.register(ResultFormTableViewCell.self, forCellReuseIdentifier: String(describing: ResultFormTableViewCell.self))
        tableView.dataSource = dataSource
        tableView.allowsSelection = false

        bottomConstraint = stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint?.isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }

    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setLayout() {
        view.backgroundColor = .systemBackground

        applyButton.setTitle("ResultForm.applyButton".localized, for: .normal)
        applyButton.setTitleColor(.systemGray, for: .normal)

        stackView = UIStackView(arrangedSubviews: [tableView, applyButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            applyButton.heightAnchor.constraint(equalToConstant: 50),
            applyButton.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            tableView.widthAnchor.constraint(equalTo: stackView.widthAnchor),

            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
        let confirmBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(confirmButtonClicked))
        self.navigationItem.leftBarButtonItem = addBarButtonItem
        self.navigationItem.rightBarButtonItem = confirmBarButtonItem
    }

    @objc func keyboardWillShow(sender: NSNotification) {
        if let info = sender.userInfo, let keyboardFrameEndUserInfoKey = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardSize = keyboardFrameEndUserInfoKey.cgRectValue.height
            bottomConstraint?.constant = -keyboardSize
        }
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        bottomConstraint?.constant = 0
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
