//
//  PostCell.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import UIKit
import SDWebImage
import Kingfisher

class PostCell: UICollectionViewCell {
    static let reuseIdentifier = "PostCell"
    
    private let postImageView = UIImageView()
    private let postTextLabel = UILabel()
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        avatarImageView.backgroundColor = .gray
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.clipsToBounds = true
        
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        
        postTextLabel.numberOfLines = 0
        
        let hStackView = UIStackView(
            arrangedSubviews: [
                avatarImageView,
                nameLabel
            ]
        )
        hStackView.axis = .horizontal
        hStackView.spacing = 8
        
        let stackView = UIStackView(
            arrangedSubviews: [
                hStackView,
                postImageView,
                postTextLabel
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 8
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            
            // Added priority to avoid conflicts
            avatarImageView.widthAnchor.constraint(equalToConstant: 40).withPriority(.defaultHigh),
            
            postImageView.heightAnchor.constraint(equalToConstant: 200),
            postImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1)
        ])
    }
    
    override func prepareForReuse() {
        postImageView.image = nil
        task?.cancel()
        task = nil
    }
    
    func configure(with post: Post) {
        if let avatarURL = URL(string: post.creator.avatar) {
            avatarImageView.kf.setImage(with: avatarURL)
        }
        
        nameLabel.text = post.creator.fullName
        
        if let firstImage = post.images.first,
           let postImageURL = URL(string: firstImage) {
            loadImage(from: post.images.first ?? "") { image in
                DispatchQueue.main.async {
                    self.postImageView.image = image
                }
            }
        }
        
        postTextLabel.text = post.postText
    }
    
    var task: URLSessionDataTask?
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors and ensure there's data
            if let error = error {
                print("Error loading image: \(error)")
                completion(nil)
                return
            }
            
            guard let data else {
                completion(nil)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            // Return the loaded image on the main thread
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        task?.resume()
    }
}

private extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
