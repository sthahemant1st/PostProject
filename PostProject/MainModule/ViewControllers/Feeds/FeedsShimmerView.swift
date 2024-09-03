//
//  FeedsShimmerView.swift
//  PostProject
//
//  Created by Hemant Shrestha on 21/08/2024.
//

import UIKit
import SkeletonView

class FeedsShimmerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        isSkeletonable = true
        
        let dummyCell1 = PostCell()
        dummyCell1.isSkeletonable = true
        
        let dummyCell2 = PostCell()
        dummyCell2.isSkeletonable = true
        
        let stackView = UIStackView(arrangedSubviews: [dummyCell1, dummyCell2])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        self.backgroundColor = .red
    }
}

