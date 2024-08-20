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
        
        loadImageTask?.cancel()
        loadImageTask = nil
    }
    
    func configure(with image: String) {
        if let postImageURL = URL(string: image) {
            loadImage(from: postImageURL) { image in
                DispatchQueue.main.async {
                    self.postImageView.image = image
                }
            }
        }
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
