//
//  CityModel.swift
//  SearchCity
//
//  Created by Vadim Denisov on 29/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import Foundation
import SwiftyJSON

class CityList {
    
    var cities: [String] = []
    
    init() {
        parseCitiesFile()
    }
    
    func parseCitiesFile() {
        cities = []
        
        guard let path = Bundle.main.path(forResource: "city.list", ofType: "json") else { return }
        
        let json = try! JSON(data: Data(contentsOf: URL(fileURLWithPath: path)))
        
        cities = json.arrayValue.map {
            $0["name"].stringValue
        }
    }
}


