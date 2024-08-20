//
//  PostCell.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import UIKit
import SDWebImage

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
        avatarImageView.roundCorners(radius: 20)
        
        postImageView.contentMode = .scaleAspectFill
        postImageView.backgroundColor = .gray
        postImageView.roundCorners(radius: 16)
        
        postTextLabel.numberOfLines = 2
        
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
            
            postImageView.heightAnchor.constraint(equalToConstant: 200),
            postImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    override func prepareForReuse() {
        avatarImageView.image = nil
        postImageView.image = nil
        nameLabel.text = ""
        postTextLabel.text = ""
        
        loadImageTask?.cancel()
        loadImageTask = nil
    }
    
    func configure(with post: Post) {
        if let avatarURL = URL(string: post.creator.avatar) {
            avatarImageView.sd_setImage(
                with: avatarURL,
                placeholderImage: .imagePlaceholder
            )
        }
        nameLabel.text = post.creator.fullName
        if let firstImage = post.images.first,
           let postImageURL = URL(string: firstImage) {
            loadImage(from: postImageURL) { image in
                DispatchQueue.main.async {
                    self.postImageView.image = image
                }
            }
        }
        postTextLabel.text = post.postText
    }
    
    private var loadImageTask: URLSessionDataTask?
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        loadImageTask = URLSession.shared.dataTask(with: url) { data, response, error in
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
        
        loadImageTask?.resume()
    }
}
