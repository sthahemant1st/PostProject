//
//  FeedsViewController.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import UIKit

class FeedsViewController: UIViewController {

    private let viewModel: FeedsViewModel
    
    init(viewModel: FeedsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        viewModel.viewDidLoad()
    }

}

