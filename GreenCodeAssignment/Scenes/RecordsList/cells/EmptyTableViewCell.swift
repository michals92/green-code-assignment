//
//  EmptyTableViewCell.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 12.05.2022.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let button = UIButton()

    private var actionHandler: Action?

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        button.setTitle(nil, for: .normal)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setAppearance()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(cellModel: EmptyTableViewCellModel) {
        titleLabel.text = cellModel.title
        button.setTitle(cellModel.buttonTitle, for: .normal)

        actionHandler = cellModel.addRecordHandler
    }

    private func setLayout() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, button])
        stackView.axis  = .vertical
        stackView.distribution  = .fillProportionally
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    private func setAppearance() {
        titleLabel.font = .systemFont(ofSize: 14, weight: .light)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center

        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.backgroundColor = .systemBlue
        button.titleLabel?.contentMode = .scaleAspectFit


        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

    }

    @objc
    private func buttonAction() {
        actionHandler?()
    }
}
