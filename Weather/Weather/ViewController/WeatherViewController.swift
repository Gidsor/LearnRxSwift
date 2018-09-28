//
//  WeatherViewController.swift
//  Weather
//
//  Created by Vadim Denisov on 28/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var weatherLabel: UILabel!

    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.cityName.bind(to: cityLabel.rx.text).disposed(by: disposeBag)
        viewModel.degrees.bind(to: weatherLabel.rx.text).disposed(by: disposeBag)
        
        cityField.rx.text.subscribe({ text in
            self.viewModel.searchText.value = text.element!!
            self.viewModel.search()
        }).disposed(by: disposeBag)
    }
    
}
