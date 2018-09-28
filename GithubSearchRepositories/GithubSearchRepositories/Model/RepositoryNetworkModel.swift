//
//  RepositoryNetworkModel.swift
//  GithubSearchRepositories
//
//  Created by Vadim Denisov on 28/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import ObjectMapper
import RxAlamofire
import RxSwift
import RxCocoa

struct RepositoryNetworkModel {
    private var repositoryName: Observable<String>
    
    lazy var rxRepositories: Driver<[Repository]> = self.fetchRepositories()
    
    init(nameObservable: Observable<String>) {
        self.repositoryName = nameObservable
    }
    
    private func fetchRepositories() -> Driver<[Repository]> {
        return repositoryName
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMapLatest { text in
                return RxAlamofire
                    .requestJSON(.get, "https://api.github.com/users/\(text)/repos")
                    .debug()
                    .catchError { error in
                        return Observable.never()
                    }
            }
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { (response, json) -> [Repository] in
                if let repos = Mapper<Repository>().mapArray(JSONObject: json) {
                    return repos
                } else {
                    return []
                }
            }
            .observeOn(MainScheduler.instance)
            .do(onNext: { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            .asDriver(onErrorJustReturn: [])
    }
}
