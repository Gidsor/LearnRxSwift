//
//  RepositoriesViewController.swift
//  GithubSearchRepositories
//
//  Created by Vadim Denisov on 28/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import UIKit
import ObjectMapper
import RxAlamofire
import RxSwift
import RxCocoa

class RepositoriesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var repositoryNetworkModel: RepositoryNetworkModel!
    
    var rxSearchBarText: Observable<String> {
        return searchBar.rx.text
            .filter { $0 != nil}
            .map { $0! }
            .filter { $0.count > 0 }
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setupRx() {
        repositoryNetworkModel = RepositoryNetworkModel(nameObservable: rxSearchBarText)
        
        repositoryNetworkModel.rxRepositories
            .drive(tableView.rx.items) { (tv, i, repository) in
                let cell = tv .dequeueReusableCell(withIdentifier: "Cell", for: IndexPath(row: i, section: 0))
                cell.textLabel?.text = repository.name
                cell.detailTextLabel?.text = repository.url
                
                return cell
            }
            .disposed(by: disposeBag)
    }
}
