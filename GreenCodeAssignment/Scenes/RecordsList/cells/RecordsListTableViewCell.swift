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
    private let typeLabel = UILabel()
    private let durationLabel = UILabel()

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

    func configure(cellModel: RecordsListTableViewCellModel) {
        let result = cellModel.sportResult
        nameLabel.text = result.name
        placeLabel.text = result.place
        typeLabel.text = result.type.rawValue
        typeLabel.textColor = result.type == .remote ? .systemGreen : .systemOrange
        durationLabel.text = result.duration.format(using: [.hour, .minute, .second])
    }

    private func setLayout() {
        let headerStackView = UIStackView(arrangedSubviews: [nameLabel, typeLabel])
        headerStackView.axis  = .horizontal
        headerStackView.distribution  = .fill
        headerStackView.alignment = UIStackView.Alignment.leading
        headerStackView.spacing = 5

        let stackView = UIStackView(arrangedSubviews: [headerStackView, placeLabel, durationLabel])
        stackView.axis  = .vertical
        stackView.distribution  = .equalSpacing
        stackView.alignment = UIStackView.Alignment.fill
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

    func setAppearance() {
        nameLabel.font = .systemFont(ofSize: 18)
        nameLabel.numberOfLines = 0

        placeLabel.font = .systemFont(ofSize: 14, weight: .medium)
        durationLabel.font = .systemFont(ofSize: 14, weight: .medium)

        typeLabel.font = .systemFont(ofSize: 12)
        typeLabel.textAlignment = .right
    }
}
