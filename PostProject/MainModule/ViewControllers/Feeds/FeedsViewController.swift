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
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.reuseIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PostCell.reuseIdentifier")
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
//        view.backgroundColor = .systemTeal
//        do {
//            let posts = try JsonHelper.convert(name: "Post", type: [Post].self)
//            print(posts)
//        } catch {
//            print(error)
//        }
//        viewModel.viewDidLoad()
//        alert(message: "Hemant", title: "Shrestha", okAction: nil)
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.posts
            .debug("Hemant")
            .bind(
                to: collectionView.rx.items(
                    cellIdentifier: "PostCell.reuseIdentifier",
                    cellType: UICollectionViewCell.self
                )
            ) { row, post, cell in
//                cell.configure(with: post)
                cell.backgroundColor = .red
            }
            .disposed(by: disposeBag)
    }

}
