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
    var weatherImage: UIImage?
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
        zipCodeField = UITextField(frame: CGRect(x: 10, y: 100, width: 200, height: 40))
        zipCodeField.borderStyle = .roundedRect
        zipCodeField.keyboardType = .numberPad
        zipCodeField.clearsOnBeginEditing = true
        view.addSubview(zipCodeField)
        
        searchWeatherButton = UIButton(frame: CGRect(x: 220, y: 100, width: 40, height: 40))
        searchWeatherButton.setTitle("Go", for: .normal)
        searchWeatherButton.setTitleColor(view.tintColor, for: .normal)
        searchWeatherButton.addTarget(self, action: #selector(loadWeather), for: .touchUpInside)
        view.addSubview(searchWeatherButton)
        
        cityLabel = UILabel(frame: CGRect(x: 10, y: 150, width: view.frame.width, height: 20))
        cityLabel.textColor = .black
        view.addSubview(cityLabel)

        currentTempLabel = UILabel(frame: CGRect(x: 10, y: 200, width: 200, height: 40))
        currentTempLabel.textColor = .black
        view.addSubview(currentTempLabel)
        
        weatherDescriptionLabel = UILabel(frame: CGRect(x: 10, y: 250, width: 200, height: 20))
        weatherDescriptionLabel.textColor = .black
        view.addSubview(weatherDescriptionLabel)
        
        todayForecastTempLabel = UILabel(frame: CGRect(x: 10, y: 280, width: 100, height: 20))
        todayForecastTempLabel.textColor = .black
        view.addSubview(todayForecastTempLabel)
        
        todayForecastDateLabel = UILabel(frame: CGRect(x: 10, y: 310, width: 100, height: 20))
        todayForecastDateLabel.textColor = .black
        view.addSubview(todayForecastDateLabel)
        
        
    }
    
    func loadWeather() {
        loadCurrentWeather()
        loadWeatherForecast()
    }

    func loadCurrentWeather() {
        // TODO: validate zipcode
        if let zipcode = zipCodeField.text {
            if let wundergroundCurrentURL = URL(string: "http://api.wunderground.com/api/494caad0c14840f0/conditions/q/\(zipcode).json") {
                WUndergroundManager.getCurrentWeatherFromAPI(url: wundergroundCurrentURL, completion: { (currentWeather) in
                    if let weather = currentWeather {
                        self.cityLabel.text = weather.cityName
                        
                        self.currentTempLabel.text = weather.currentTemp
                        
                        self.weatherDescriptionLabel.text = weather.description

                    }
                })
            }
        }
        
    }

    
    func loadWeatherForecast() {
        if let zipcode = zipCodeField.text {
            if let wundergroundForecastURL = URL(string: "http://api.wunderground.com/api/494caad0c14840f0/forecast/q/\(zipcode).json") {
                WUndergroundManager.getThreeDayWeatherFromAPI(url: wundergroundForecastURL, completion: { (forecasts: [WeatherForecast]?) in
                    if let firstForecast = forecasts?[0] {
                        self.todayForecastTempLabel.text = "\(firstForecast.highTemp)/\(firstForecast.lowTemp)"
                        self.todayForecastDateLabel.text = "\(firstForecast.date)"
                    }
                })
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.zipCodeField.resignFirstResponder()
    }
}
