//
//  FeedsViewModel.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import Foundation

final class FeedsViewModel {
    weak var viewType: BaseViewType?
    
    func viewDidLoad() {
        viewType?.showProgressHud()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.viewType?.hideProgressHud()
        }
    }
}
