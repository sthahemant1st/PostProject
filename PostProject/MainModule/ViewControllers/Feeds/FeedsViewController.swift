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
    private let refreshControl = UIRefreshControl()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            PostCell.self,
            forCellWithReuseIdentifier: PostCell.reuseIdentifier
        )
        collectionView.register(
            PostMultipleImageCell.self,
            forCellWithReuseIdentifier: PostMultipleImageCell.reuseIdentifier
        )
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
        refreshControl.refreshManually()
    }
    
    private func setupUI() {
        title = "Feed"
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.fetchPosts()
    }
    
    private func bindViewModel() {
        viewModel.isFetchingObs
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.postsObservable.subscribe { _ in
            self.collectionView.reloadData()
        }
        .disposed(by: disposeBag)
        
//        viewModel.postsObservable
//            .bind(
//                to: collectionView.rx.items(
//                    cellIdentifier: PostCell.reuseIdentifier,
//                    cellType: PostCell.self
//                )
//            ) { row, post, cell in
//                cell.configure(with: post)
//            }
//            .disposed(by: disposeBag)
    }
    private var estimatedPostCellSize: CGSize?
    private var estimatedPostMultipleCellSize: CGSize?
}

extension FeedsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if indexPath.row.isMultiple(of: 2) {
            if let estimatedPostCellSize { return estimatedPostCellSize }
            
            let dummyCell = PostCell()
            let post: Post = .dummyForSizeCalc
            dummyCell.configure(with: post)
            
            let targetSize = CGSize(
                width: collectionView.frame.width - 32,
                height: UIView.layoutFittingCompressedSize.height
            )
            
            estimatedPostCellSize = dummyCell.systemLayoutSizeFitting(
                targetSize,
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )
            return estimatedPostCellSize!
        } else {
            if let estimatedPostCellSize { return estimatedPostCellSize }
            
            let dummyCell = PostMultipleImageCell()
            let post: Post = .dummyForSizeCalc
            dummyCell.configure(with: post)
            
            let targetSize = CGSize(
                width: collectionView.frame.width - 32,
                height: UIView.layoutFittingCompressedSize.height
            )
            
            estimatedPostMultipleCellSize = dummyCell.systemLayoutSizeFitting(
                targetSize,
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )
            return estimatedPostMultipleCellSize!
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
}

extension FeedsViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.posts.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.row.isMultiple(of: 2) {
            let cell: PostCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCell.reuseIdentifier,
                for: indexPath
            ) as! PostCell
            let post = viewModel.posts[indexPath.row]
            cell.configure(with: post)
            return cell
        } else {
            let cell: PostMultipleImageCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostMultipleImageCell.reuseIdentifier,
                for: indexPath
            ) as! PostMultipleImageCell
            let post = viewModel.posts[indexPath.row]
            cell.configure(with: post)
            return cell
        }
    }
}
