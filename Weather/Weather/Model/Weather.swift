//
//  Weather.swift
//  Weather
//
//  Created by Vadim Denisov on 28/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import SwiftyJSON

class Weather {
    var name: String?
    var degrees: Double?
    
    init(json: JSON) {
        name = json["name"].stringValue
        
        if name != "" {
            // Convert from kelvin to celsius
            degrees = (json["main"]["temp"].doubleValue - 273.15).rounded()
        } else {
            name = "Not found"
        }
    }
}
