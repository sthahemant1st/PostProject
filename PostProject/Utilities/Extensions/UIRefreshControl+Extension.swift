//
//  UIRefreshControl+Extension.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import UIKit

extension UIRefreshControl {
    func refreshManually() {
        beginRefreshing()
        sendActions(for: .valueChanged)
    }
}
