//
//  SearchTableViewController.swift
//  SearchCity
//
//  Created by Vadim Denisov on 27/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchCity = [String]()
    var cityList = CityList()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.rx
            .text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] query in
                self.searchCity = self.cityList.cities.filter { $0.hasPrefix(query) }
                self.tableView.reloadData()
            })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCity.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.textLabel?.text = searchCity[indexPath.row]
        return cell
    }
}
