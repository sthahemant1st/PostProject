//
//  FeedsViewController.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import UIKit
import RxSwift
import RxCocoa

class FeedsViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let viewModel: FeedsViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: FeedsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchPosts()
    }
    
    private func setupUI() {
        title = "Feed"
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.postsObservable
            .bind(
                to: collectionView.rx.items(
                    cellIdentifier: PostCell.reuseIdentifier,
                    cellType: PostCell.self
                )
            ) { row, post, cell in
                cell.configure(with: post)
            }
            .disposed(by: disposeBag)
    }

}

extension FeedsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let dummyCell = PostCell()
        let post: Post = viewModel.posts[indexPath.row]
        dummyCell.configure(with: post)
        
        // Calculate the target size fitting width while allowing height to be dynamic
        let targetSize = CGSize(width: collectionView.frame.width - 32, height: UIView.layoutFittingCompressedSize.height)
        
        // Calculate the actual size based on Auto Layout
        let estimatedSize = dummyCell.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return estimatedSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
}
