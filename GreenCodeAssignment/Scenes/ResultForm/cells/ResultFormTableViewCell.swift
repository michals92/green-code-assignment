//
//  ResultFormTableViewCell.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 11.05.2022.
//

import UIKit

class ResultFormTableViewCell: UITableViewCell {

    private let nameLabel = UILabel()
    private var stackView = UIStackView()

    private var textField: UITextField?
    private var pickerView: UIPickerView?
    private var segmentedControl: UISegmentedControl?

    private var textFieldHandler: ((String) -> Void)?
    private var durationFieldHandler: ((Double) -> Void)?

    private var hours = 0
    private var minutes = 0
    private var seconds = 0

    private var allSportResults = SportResultType.allCases

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        textField?.text = nil
        textField?.placeholder = nil

        textFieldHandler = nil
        durationFieldHandler = nil

        if let textField = textField {
            stackView.removeArrangedSubview(textField)
            self.textField = nil
        }

        if let pickerView = pickerView {
            stackView.removeArrangedSubview(pickerView)
            self.pickerView = nil
        }

        if let segmentedControl = segmentedControl {
            stackView.removeArrangedSubview(segmentedControl)
            self.segmentedControl = nil
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(cellModel: ResultFormTableViewCellModel) {
        switch cellModel.formItem.type {
        case .duration:
            let pickerView = UIPickerView()
            pickerView.dataSource = self
            pickerView.delegate = self

            self.pickerView = pickerView
            stackView.addArrangedSubview(pickerView)
            durationFieldHandler = cellModel.durationFieldHandler
        case .type:
            let segmentedControl = UISegmentedControl()

            for (index, item) in allSportResults.enumerated() {
                segmentedControl.insertSegment(withTitle: item.rawValue.capitalized, at: index, animated: false)
            }

            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.fixBackground()
            segmentedControl.backgroundColor = .systemBackground
            segmentedControl.selectedSegmentTintColor = .systemGray.withAlphaComponent(0.2)
            segmentedControl.addTarget(self, action: #selector(recordTypeDidChange), for: .valueChanged)

            self.segmentedControl = segmentedControl
            stackView.addArrangedSubview(segmentedControl)
            textFieldHandler = cellModel.textFieldHandler
        case .text:
            let textField = UITextField()
            textField.font = .systemFont(ofSize: 18, weight: .medium)
            textField.placeholder = "ResultFormTableViewCell.textFieldPlaceholder".localized + cellModel.formItem.name

            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

            self.textField = textField
            stackView.addArrangedSubview(textField)

            let underlineView = UIView()
            underlineView.backgroundColor = .lightGray
            underlineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

            stackView.addArrangedSubview(underlineView)
            textFieldHandler = cellModel.textFieldHandler
        }

        nameLabel.text = cellModel.formItem.name.capitalized
    }

    private func setLayout() {
        nameLabel.font = .systemFont(ofSize: 12, weight: .medium)

        stackView.addArrangedSubview(nameLabel)

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 5
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
        if let textField = textField {
            textFieldHandler?(textField.text ?? "")
        }
    }

    @objc func recordTypeDidChange() {
        if let segmentedControl = segmentedControl {
            textFieldHandler?(allSportResults[segmentedControl.selectedSegmentIndex].rawValue)
        }
    }
}

extension ResultFormTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 25
        case 1, 2:
            return 60
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(row) + " " + "ResultFormTableViewCell.hourLabel".localized
        case 1:
            return String(row) + " " + "ResultFormTableViewCell.minuteLabel".localized
        case 2:
            return String(row) + " " + "ResultFormTableViewCell.secondLabel".localized
        default:
            return ""
        }
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hours = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break
        }

        var timeInterval = 0.0

        timeInterval += Double(hours) * 3600.0
        timeInterval += Double(minutes) * 60.0
        timeInterval += Double(seconds)

        durationFieldHandler?(timeInterval)
    }
}
