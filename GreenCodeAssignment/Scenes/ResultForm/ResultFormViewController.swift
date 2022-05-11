//
//  ResultFormViewController.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

class ResultFormViewController: UIViewController {

    var viewModel: ResultFormViewModelInput?

    override func loadView() {
        super.loadView()
        setLayout()
        title = "ResultForm.title".localized
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }

    func setLayout() {
        view.backgroundColor = .systemBackground

        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
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
