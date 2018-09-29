//
//  Weather.swift
//  Weather
//
//  Created by Vadim Denisov on 28/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import SwiftyJSON

class Weather {
    var name: String? = "Not found"
    var degrees: Double? = 0
    
    init(json: JSON) {
        let cityName = json["name"].stringValue
        
        if cityName != "" {
            name = cityName
            // Convert from kelvin to celsius
            degrees = (json["main"]["temp"].doubleValue - 273.15).rounded()
        }
    }
}
