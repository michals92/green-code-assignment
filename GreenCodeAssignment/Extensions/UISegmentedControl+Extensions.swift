//
//  UISegmentedControl+Extensions.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 11.05.2022.
//

import UIKit

extension UISegmentedControl {
    func fixBackground() {
        if #available(iOS 13.0, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for index in 0...self.numberOfSegments-1 {
                    let backgroundSegmentView = self.subviews[index]
                    backgroundSegmentView.isHidden = true
                }
            }
        }
    }
}
