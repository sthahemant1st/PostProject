//
//  ImageCell.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import UIKit
import SDWebImage

class ImageCell: UICollectionViewCell {
    static let reuseIdentifier = "ImageCell"
    
    private let postImageView = UIImageView()
    private let imageLoader = ImageLoader()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.contentMode = .scaleAspectFill
        postImageView.backgroundColor = .gray
        postImageView.roundCorners(radius: 16)
        contentView.addSubview(postImageView)
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
    }
    
    override func prepareForReuse() {
        postImageView.image = nil
        
        imageLoader.cancel()
    }
    
    func configure(with image: String) {
        if let postImageURL = URL(string: image) {
            imageLoader.loadImage(from: postImageURL) { image in
                DispatchQueue.main.async {
                    self.postImageView.image = image
                }
            }
        }
    }
}
