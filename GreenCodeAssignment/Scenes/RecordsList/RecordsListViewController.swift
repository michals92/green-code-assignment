//
//  RecordsListViewController.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

class RecordsListViewController: UIViewController {
    private let tableView = UITableView()
    private let segmentedControl = UISegmentedControl()
    private let refreshControl = UIRefreshControl()
    private let emptyTitleLabel = UILabel()
    private let emptyButton = UIButton()
    private var emptyStackView: UIStackView?

    var viewModel: RecordsListViewModelInput?

    private var dataSource: RecordsListTableViewDataSource?

    override func loadView() {
        super.loadView()
        setLayout()
        setEmptyLayout()
        setAppearance()
        setSegmentedControlItems()
        
        title = "RecordsList.title".localized

        tableView.register(RecordsListTableViewCell.self, forCellReuseIdentifier: String(describing: RecordsListTableViewCell.self))

        let dataSource = RecordsListTableViewDataSource()
        self.dataSource = dataSource
        tableView.dataSource = dataSource
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()

        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(refreshed), for: .valueChanged)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }

    private func setLayout() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16)
        ])

        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
    }

    private func setEmptyLayout() {
        let emptyStackView = UIStackView(arrangedSubviews: [emptyTitleLabel, emptyButton])
        emptyStackView.axis  = .vertical
        emptyStackView.distribution  = .fill
        emptyStackView.alignment = .center
        emptyStackView.spacing = 10
        emptyStackView.translatesAutoresizingMaskIntoConstraints = false
        emptyStackView.isHidden = true

        self.emptyStackView = emptyStackView
        view.addSubview(emptyStackView)

        NSLayoutConstraint.activate([
            emptyStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            emptyStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])

    }

    private func setAppearance() {
        emptyTitleLabel.text = "RecordsListTableViewDataSource.title".localized
        emptyButton.setTitle("RecordsListTableViewDataSource.buttonTitle".localized, for: .normal)

        emptyTitleLabel.font = .systemFont(ofSize: 14, weight: .light)
        emptyTitleLabel.numberOfLines = 0
        emptyTitleLabel.textAlignment = .center

        emptyButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        emptyButton.backgroundColor = .systemBlue
        emptyButton.titleLabel?.contentMode = .scaleAspectFit

        emptyButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        emptyButton.layer.cornerRadius = 4
        emptyButton.addTarget(self, action: #selector(emptyButtonAction), for: .touchUpInside)
    }

    private func setSegmentedControlItems() {
        let items = RecordListType.allCases
        for (index, item) in items.enumerated() {
            segmentedControl.insertSegment(withTitle: item.title(), at: index, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0

        segmentedControl.fixBackground()
        segmentedControl.backgroundColor = .systemBackground
        segmentedControl.selectedSegmentTintColor = .systemGray.withAlphaComponent(0.2)

        segmentedControl.addTarget(self, action: #selector(recordTypeDidChange(_:)), for: .valueChanged)
    }

    @objc
    private func addButtonClicked() {
        viewModel?.showResultForm()
    }

    @objc
    private func refreshed() {
        viewModel?.getResultsForCurrentType()
    }

    @objc
    private func recordTypeDidChange(_ segmentedControl: UISegmentedControl) {
        let index = segmentedControl.selectedSegmentIndex
        viewModel?.getResults(for: RecordListType(rawValue: index) ?? .all)
    }

    @objc
    private func emptyButtonAction() {
        viewModel?.showResultForm()
    }
}

extension RecordsListViewController: RecordsListViewControllerInput {
    func startLoading() {
        if !refreshControl.isRefreshing {
            refreshControl.beginRefreshing()
        }
    }

    func stopLoading() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

    func reloadData(cellModels: [RecordsListTableViewCellModel], type: RecordListType) {
        emptyStackView?.isHidden = !cellModels.isEmpty
        dataSource?.cellModels = cellModels
        dataSource?.type = type
        tableView.reloadData()
    }
}
