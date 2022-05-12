//
//  UITextField+Extensions.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 12.05.2022.
//

import UIKit

extension UITextField {

    func addUnderLine() {
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0.0, y: self.bounds.height + 1, width: self.bounds.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2).cgColor

        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
}
