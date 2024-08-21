//
//  ErrorStateView.swift
//  PostProject
//
//  Created by Hemant Shrestha on 21/08/2024.
//

import UIKit

class ErrorStateView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 18)
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
        return button
    }()
    
    private let title: String
    private let message: String
    private let onRefreshButtonTapped: (() -> Void)?
    
    init(
        title: String,
        message: String,
        onRefreshButtonTapped: (() -> Void)?
    ) {
        self.title = title
        self.message = message
        self.onRefreshButtonTapped = onRefreshButtonTapped
        super.init(frame: .zero)
        setupView()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
       fatalError("coder: NSCoder")
    }
    
    private func setupView() {
//        addSubview(titleLabel)
//        addSubview(messageLabel)
//        addSubview(refreshButton)
        titleLabel.text = title
        messageLabel.text = message
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            messageLabel,
            refreshButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        // Set up constraints
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setupActions() {
        refreshButton.addTarget(self, action: #selector(handleRefreshButtonTapped), for: .touchUpInside)
    }
    
    @objc private func handleRefreshButtonTapped() {
        onRefreshButtonTapped?()
    }
}
