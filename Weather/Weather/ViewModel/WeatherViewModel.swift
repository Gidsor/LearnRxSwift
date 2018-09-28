//
//  ViewModel.swift
//  Weather
//
//  Created by Vadim Denisov on 28/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON
import RxAlamofire

class ViewModel {
    
    private struct Constants {
        static let URLPrefix = "http://api.openweathermap.org/data/2.5/weather?q="
        static let URLPostfix = "&APPID=c09033197bced1a9d6291206ca900759"
    }
    
    let disposeBag = DisposeBag()
    
    var searchText = Variable<String>("")
    var cityName = PublishSubject<String>()
    var degrees = PublishSubject<String>()
    
    var weather: Weather? {
        didSet {
            if let name = weather?.name {
                DispatchQueue.main.async {
                    self.cityName.onNext(name)
                }
            }
            
            if let temperature = weather?.degrees {
                DispatchQueue.main.async {
                    self.degrees.onNext("\(temperature)˚ C")
                }
            }
        }
    }
    
    func search() {
        _ = searchText
            .asObservable()
            .map { text in
                return URLSession.shared.rx.json(url: URL(string: Constants.URLPrefix + "\(text)" + Constants.URLPostfix)!)
            }
            .switchLatest().map(JSON.init)
            .subscribe({ json in
                self.weather = Weather(json: json.element ?? JSON(parseJSON: "{}"))
            })
            .disposed(by: disposeBag)
    }
}
