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
    var image: UIImage
    var imageURL: String
    var description: String
    
    // from current_observation json
    init(json: JSON) {
        self.cityName = json["display_location"]["full"].stringValue
        self.currentTemp = String(json["temp_f"].floatValue) + "\u{00B0}F"
        self.description = json["weather"].stringValue
        self.imageURL = json["icon_url"].stringValue
        self.image = UIImage()
        if let imageFromURL = UIImage.getImageFromURLString(urlString: imageURL) {
            self.image = imageFromURL
        } else {
            self.image = UIImage()
        }
    }
    
}

class WeatherForecast {
    var highTemp: String
    var lowTemp: String
    var imageURL: String
    var image: UIImage
    var date: String
    
    // from forecastday index json
    init(json: JSON) {
        self.highTemp = json["high"]["fahrenheit"].stringValue + "\u{00B0}F"
        self.lowTemp = json["low"]["fahrenheit"].stringValue + "\u{00B0}F"
        self.imageURL = json["icon_url"].stringValue
        self.date = "\(json["date"]["month"].intValue)/\(json["date"]["day"].intValue)"
        if let imageFromURL = UIImage.getImageFromURLString(urlString: imageURL) {
            self.image = imageFromURL
        } else {
            self.image = UIImage()
        }
    }
}

extension UIImage {
    static func getImageFromURLString(urlString: String) -> UIImage? {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
            }
        }
        return nil
    }
}
