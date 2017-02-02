//
//  WUndergroundManager.swift
//  WeatherApp
//
//  Created by Mindy Lou on 2/1/17.
//  Copyright © 2017 Mindy Lou. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class WUndergroundManager {
    
    static func getCurrentWeatherFromAPI(url: URL, completion: @escaping (CurrentWeather?) -> Void) {
        Alamofire.request(url, method: .get)
            .validate().responseJSON { response in
                switch response.result {
                case let .success(data):
                    let currentWeatherJSON = JSON(data)["current_observation"]
                    let currentWeather = CurrentWeather(json: currentWeatherJSON)
                    
                    completion(currentWeather)
                
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    static func getThreeDayWeatherFromAPI(url: URL, completion: @escaping ([WeatherForecast]?) -> Void) {
        Alamofire.request(url, method: .get)
        .validate().responseJSON { response in
            switch response.result {
            case let .success(data):
                let simpleForecastJSONArray = JSON(data)["forecast"]["simpleforecast"]["forecastday"].arrayValue
                var threeDayWeatherArray = [WeatherForecast]()
                for periodJSON in simpleForecastJSONArray {
                    threeDayWeatherArray.append(WeatherForecast(json: periodJSON))
                }
                completion(threeDayWeatherArray)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
