//
//  Weather.swift
//  WeatherApp
//
//  Created by Mindy Lou on 2/1/17.
//  Copyright © 2017 Mindy Lou. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class CurrentWeather {
    var cityName: String
    var currentTemp: String
//    var image: UIImage
    var description: String
    
    // from current-observation json
    init(json: JSON) {
        self.cityName = json["display_location"]["full"].stringValue
        self.currentTemp = String(json["temp_f"].floatValue)
        self.description = json["weather"].stringValue
    }
    
}
