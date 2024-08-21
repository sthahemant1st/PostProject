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
    
    private let _viewState = BehaviorRelay<ViewState<Posts>>(value: .ideal)
    
    var viewStateObs: Observable<ViewState<Posts>> {
        return _viewState.asObservable()
    }
    var posts: Posts {
        return switch _viewState.value {
        case .success(response: let response):
            response
        default:
            []
        }
    }
    var numberOfItemsInSection: Int {
        posts.count
    }
//    private let _isFetching = BehaviorRelay(value: false)
//
//    var isFetchingObs: Observable<Bool> {
//        _isFetching.asObservable()
//    }
//    var postsObservable: Observable<[Post]> {
//        return _posts.asObservable()
//    }
//    var posts: [Post] {
//        return _posts.value
//    }
    
    init(postsUseCase: PostsUseCase) {
        self.postsUseCase = postsUseCase
        setupBindings()
    }
    
    private func setupBindings() {}
    
    func fetchPosts() {
        Task { @MainActor in
            _viewState.accept(.loading(placeholder: nil))
            
            do {
                let posts = try await postsUseCase.fetch()
                _viewState.accept(.success(response: posts))
            } catch {
                _viewState.accept(.error(error: error))
            }
        }
    }
}

enum ViewState<T: Decodable> {
    case ideal
    case loading(placeholder: T?)
    case success(response: T)
    case error(error: Error)
}
