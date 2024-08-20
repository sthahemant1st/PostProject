//
//  FeedsViewModel.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import Foundation
import RxSwift
import RxCocoa

final class FeedsViewModel {
    weak var viewType: BaseViewType?
    private let postsUseCase: PostsUseCase
    private let disposeBag = DisposeBag()
    
    private let _posts = BehaviorRelay<[Post]>(value: [])
    private let _isFetching = BehaviorRelay(value: false)
    
    var isFetchingObs: Observable<Bool> {
        _isFetching.asObservable()
    }
    var postsObservable: Observable<[Post]> {
        return _posts.asObservable()
    }
    var posts: [Post] {
        return _posts.value
    }
    
    init(postsUseCase: PostsUseCase) {
        self.postsUseCase = postsUseCase
        setupBindings()
    }
    
    private func setupBindings() {}
    
    func fetchPosts() {
        Task { @MainActor in
            defer { _isFetching.accept(false) }
            _isFetching.accept(true)
            _posts.accept([])
            
            do {
                let posts = try await postsUseCase.fetch()
                self._posts.accept(posts)
            } catch {
                _posts.accept([])
                viewType?.alert(
                    message: error.localizedDescription,
                    title: "Error",
                    okAction: nil
                )
            }
        }
    }
}
