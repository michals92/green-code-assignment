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
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.viewDidLoad()
    }

    func setLayout() {
        view.backgroundColor = .systemBackground
    }
}

extension ResultFormViewController: ResultFormViewControllerInput {
    
}
