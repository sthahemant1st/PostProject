//
//  EmptyStateView.swift
//  PostProject
//
//  Created by Hemant Shrestha on 21/08/2024.
//

import UIKit

class EmptyStateView: UIView {
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "No Items Available"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Refresh", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let onRefreshButtonTapped: (() -> Void)?
    
    init(onRefreshButtonTapped: (() -> Void)?) {
        self.onRefreshButtonTapped = onRefreshButtonTapped
        super.init(frame: .zero)
        setupView()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("coder: NSCoder")
    }
    
    private func setupView() {
        addSubview(messageLabel)
        addSubview(refreshButton)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            
            refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            refreshButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupActions() {
        refreshButton.addTarget(self, action: #selector(handleRefreshButtonTapped), for: .touchUpInside)
    }
    
    @objc private func handleRefreshButtonTapped() {
        onRefreshButtonTapped?()
    }
}
