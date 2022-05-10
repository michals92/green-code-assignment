//
//  RecordsListTableViewCell.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

class RecordsListTableViewCell: UITableViewCell {

    private let nameLabel = UILabel()
    private let placeLabel = UILabel()

    // duration, type

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        placeLabel.text = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(result: SportResult) {
        nameLabel.text = result.name
        placeLabel.text = result.place
    }

    private func setLayout() {
        nameLabel.numberOfLines = 0
        nameLabel.text = "test"

        let stackView = UIStackView(arrangedSubviews: [nameLabel, placeLabel])
        stackView.axis  = .vertical
        stackView.distribution  = .equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
}
