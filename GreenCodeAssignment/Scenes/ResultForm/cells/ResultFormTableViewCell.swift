//
//  ResultFormTableViewCell.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 11.05.2022.
//

import UIKit

class ResultFormTableViewCell: UITableViewCell {

    private let nameLabel = UILabel()
    private let textField = UITextField()
    private var textFieldHandler: ((String) -> Void)?

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        textField.text = nil
        textField.placeholder = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(cellModel: ResultFormTableViewCellModel) {
        nameLabel.text = cellModel.formItem.name.capitalized
        textFieldHandler = cellModel.textFieldHandler
    }

    private func setLayout() {
        nameLabel.numberOfLines = 0
        textField.borderStyle = .roundedRect
        nameLabel.font = .systemFont(ofSize: 12, weight: .medium)

        let stackView = UIStackView(arrangedSubviews: [nameLabel, textField])

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    @objc func textFieldDidChange() {
        textFieldHandler?(textField.text ?? "")
    }
}
