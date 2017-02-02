//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mindy Lou on 2/1/17.
//  Copyright © 2017 Mindy Lou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var zipCodeField: UITextField!
    var searchWeatherButton: UIButton!
    var weatherImageView: UIImageView!
    var cityLabel: UILabel!
    var currentTempLabel: UILabel!
    var weatherDescriptionLabel: UILabel!
    var todayForecastTempLabel: UILabel!
    var todayForecastDateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        let instructionLabel = UILabel(frame: CGRect(x: 13, y: 19+24, width: 155, height: 14))
        instructionLabel.text = "Enter a 5-digit zip code here: "
        instructionLabel.font = UIFont.wth12PtFont()
        instructionLabel.textColor = .black
        view.addSubview(instructionLabel)
        
        zipCodeField = UITextField(frame: CGRect(x: 13, y: 33+26, width: 283, height: 33))
        zipCodeField.borderStyle = .roundedRect
        zipCodeField.keyboardType = .numberPad
        zipCodeField.clearsOnBeginEditing = true
        view.addSubview(zipCodeField)
        
        searchWeatherButton = UIButton(frame: CGRect(x: 308, y: 37+24, width: 57, height: 21))
        searchWeatherButton.setTitle("Search", for: .normal)
        searchWeatherButton.setTitleColor(view.tintColor, for: .normal)
        searchWeatherButton.titleLabel?.font = UIFont.wth18PtFont()
        searchWeatherButton.addTarget(self, action: #selector(loadWeather), for: .touchUpInside)
        view.addSubview(searchWeatherButton)
        
        cityLabel = UILabel(frame: CGRect(x: 23, y: 102, width: 350, height: 42))
        cityLabel.textColor = .black
        cityLabel.font = UIFont.wth36PtFont()
        view.addSubview(cityLabel)

        currentTempLabel = UILabel(frame: CGRect(x: 23, y: 146, width: 140, height: 42))
        currentTempLabel.textColor = .black
        currentTempLabel.font = UIFont.wth36PtFont()
        view.addSubview(currentTempLabel)
        
        weatherDescriptionLabel = UILabel(frame: CGRect(x: 23, y: 188, width: 200, height: 23))
        weatherDescriptionLabel.textColor = .black
        view.addSubview(weatherDescriptionLabel)
        
        todayForecastTempLabel = UILabel(frame: CGRect(x: 23, y: 226, width: 200, height: 23))
        todayForecastTempLabel.textColor = .black
        view.addSubview(todayForecastTempLabel)
        
        todayForecastDateLabel = UILabel(frame: CGRect(x: 23, y: 252, width: 100, height: 23))
        todayForecastDateLabel.textColor = .black
        view.addSubview(todayForecastDateLabel)
        
        weatherImageView = UIImageView(image: nil)
        weatherImageView.frame = CGRect(x: 214, y: 188, width: 100, height: 100)
        weatherImageView.clipsToBounds = true
        view.addSubview(weatherImageView)
        
    }
    
    func loadWeather() {
        zipCodeField.resignFirstResponder()
        loadCurrentWeather()
        loadWeatherForecast()
    }

    func loadCurrentWeather() {
        if let zipcode = zipCodeField.text {
            if let wundergroundCurrentURL = URL(string: "http://api.wunderground.com/api/494caad0c14840f0/conditions/q/\(zipcode).json") {
                WUndergroundManager.getCurrentWeatherFromAPI(url: wundergroundCurrentURL, completion: { (currentWeather) in
                    if let weather = currentWeather {
                        self.cityLabel.text = weather.cityName
                        
                        self.currentTempLabel.text = weather.currentTemp
                        
                        self.weatherDescriptionLabel.text = weather.description
                        
                        self.weatherImageView.image = weather.image

                    }
                })
            }
        }
        
    }

    
    func loadWeatherForecast() {
        if let zipcode = zipCodeField.text {
            if let wundergroundForecastURL = URL(string: "http://api.wunderground.com/api/494caad0c14840f0/forecast/q/\(zipcode).json") {
                WUndergroundManager.getThreeDayWeatherFromAPI(url: wundergroundForecastURL, completion: { (forecasts: [WeatherForecast]?) in
                    if let forecastCount = forecasts?.count {
                        if forecastCount > 0 {
                            if let firstForecast = forecasts?[0] {
                                self.todayForecastTempLabel.text = "\(firstForecast.highTemp)/\(firstForecast.lowTemp)"
                                self.todayForecastDateLabel.text = "\(firstForecast.date)"
                            }
                        } else {
                            self.todayForecastTempLabel.text = "Invalid zip code. Try again"
                        }
                    }
                })
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.zipCodeField.resignFirstResponder()
    }
}
