//
//  ResultFormTableViewCell.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 11.05.2022.
//

import UIKit

class ResultFormTableViewCell: UITableViewCell {

    private let nameLabel = UILabel()
    private let valueTextField = UITextField()

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        valueTextField.text = nil
        valueTextField.placeholder = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(placeholderText: String) {
        nameLabel.text = "\(placeholderText.capitalized):"
    }

    private func setLayout() {
        nameLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [nameLabel, valueTextField])

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
