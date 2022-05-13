//
//  RecordsListTableViewCell.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

class RecordsListTableViewCell: UITableViewCell {

    private let nameLabel = UILabel()
    private let typeLabel = UILabel()

    private let durationLabel = UILabel()
    private let placeLabel = UILabel()

    // display duration + type

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        placeLabel.text = nil
        typeLabel.text = nil
        durationLabel.text = nil
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

    func configure(cellModel: RecordsListTableViewCellModel, hideType: Bool) {
        let result = cellModel.sportResult
        nameLabel.text = result.name
        placeLabel.text = result.place
        typeLabel.text = result.type.rawValue.capitalized
        typeLabel.textColor = result.type == .remote ? .systemGreen : .systemOrange
        typeLabel.isHidden = hideType
        durationLabel.text = result.duration.format(using: [.hour, .minute, .second])
    }

    private func groupViewWithTitle(view: UIView, title: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.text = title
        let groupStackView = UIStackView(arrangedSubviews: [titleLabel, view])
        groupStackView.axis = .vertical
        groupStackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return groupStackView
    }

    private func setLayout() {
        let headerStackView = UIStackView(arrangedSubviews: [nameLabel, typeLabel])
        headerStackView.axis  = .horizontal
        headerStackView.spacing = 5
        typeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        let placeStackView = groupViewWithTitle(view: placeLabel, title: "RecordsListTableViewCell.placeTitle".localized)
        let durationStackView = groupViewWithTitle(view: durationLabel, title: "RecordsListTableViewCell.durationTitle".localized)

        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        separatorView.widthAnchor.constraint(equalToConstant: 0.5).isActive = true

        let groupStackView = UIStackView(arrangedSubviews: [durationStackView, separatorView, placeStackView])
        groupStackView.spacing = 20

        let stackView = UIStackView(arrangedSubviews: [headerStackView, groupStackView])
        stackView.axis  = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            headerStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    private func setAppearance() {
        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        nameLabel.numberOfLines = 0

        placeLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        durationLabel.font = .systemFont(ofSize: 16, weight: .semibold)

        typeLabel.font = .systemFont(ofSize: 12)
        typeLabel.textAlignment = .right
    }
}
