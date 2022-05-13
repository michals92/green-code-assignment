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

    var viewModel: RecordsListViewModelInput?
    var dataSource: RecordsListTableViewDataSource?

    override func loadView() {
        super.loadView()
        setLayout()
        setSegmentedControlItems()
        title = "RecordsList.title".localized

        tableView.register(RecordsListTableViewCell.self, forCellReuseIdentifier: String(describing: RecordsListTableViewCell.self))
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: String(describing: EmptyTableViewCell.self))

        let emptyTableViewCellModel = EmptyTableViewCellModel(
            title: "RecordsListTableViewDataSource.title".localized,
            buttonTitle: "RecordsListTableViewDataSource.buttonTitle".localized) { [weak self] in
                self?.viewModel?.showResultForm()
            }

        let dataSource = RecordsListTableViewDataSource(emptyCellModel: emptyTableViewCellModel)
        self.dataSource = dataSource
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.allowsSelection = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }

    func setLayout() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = UIStackView.Alignment.center
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

    func setSegmentedControlItems() {
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

    @objc func addButtonClicked() {
        viewModel?.showResultForm()
    }

    @objc func recordTypeDidChange(_ segmentedControl: UISegmentedControl) {
        let index = segmentedControl.selectedSegmentIndex
        viewModel?.getResults(for: RecordListType(rawValue: index) ?? .all)
    }
}

extension RecordsListViewController: RecordsListViewControllerInput {
    func reloadData(cellModels: [RecordsListTableViewCellModel], type: RecordListType) {
        dataSource?.cellModels = cellModels
        dataSource?.type = type
        tableView.reloadData()
    }
}
