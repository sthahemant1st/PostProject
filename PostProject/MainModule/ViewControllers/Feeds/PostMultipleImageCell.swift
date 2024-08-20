//
//  PostMultipleImageCell.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import UIKit
import SDWebImage

class PostMultipleImageCell: UICollectionViewCell {
    static let reuseIdentifier = "PostMultipleImageCell"
    
    private var collectionView: UICollectionView!
    private let postTextLabel = UILabel()
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    
    private var images = [String]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.register(
            ImageCell.self,
            forCellWithReuseIdentifier: ImageCell.reuseIdentifier
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        
        avatarImageView.backgroundColor = .gray
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.roundCorners(radius: 20)
        
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
                collectionView,
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
            
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    override func prepareForReuse() {
        avatarImageView.image = nil
        nameLabel.text = ""
        postTextLabel.text = ""
        images = []
    }
    
    func configure(with post: Post) {
        if let avatarURL = URL(string: post.creator.avatar) {
            avatarImageView.sd_setImage(
                with: avatarURL,
                placeholderImage: .imagePlaceholder
            )
        }
        nameLabel.text = post.creator.fullName
        postTextLabel.text = post.postText
        images = post.images
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(1)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.orthogonalScrollingBehavior = .paging
        
        let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(
            section: section,
            configuration: layoutConfiguration
        )
        return layout
    }
}

extension PostMultipleImageCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: ImageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCell.reuseIdentifier,
            for: indexPath
        ) as! ImageCell
        let image = images[indexPath.row]
        cell.configure(with: image)
        return cell
    }
}
