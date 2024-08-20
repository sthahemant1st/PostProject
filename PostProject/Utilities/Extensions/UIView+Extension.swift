//
//  UIView+Extension.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
