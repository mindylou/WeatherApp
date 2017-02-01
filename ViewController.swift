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
    var currentTemp: UILabel!
    var weatherDescriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        zipCodeField = UITextField(frame: CGRect(x: 10, y: 100, width: 200, height: 40))
        zipCodeField.borderStyle = .roundedRect
        zipCodeField.keyboardType = .numberPad
        view.addSubview(zipCodeField)
        
        searchWeatherButton = UIButton(frame: CGRect(x: 220, y: 100, width: 40, height: 40))
        searchWeatherButton.setTitle("Go", for: .normal)
        searchWeatherButton.setTitleColor(view.tintColor, for: .normal)
        searchWeatherButton.addTarget(self, action: #selector(loadCurrentWeather), for: .touchUpInside)
        view.addSubview(searchWeatherButton)
        
    }

    func loadCurrentWeather() {
        // TODO: validate zipcode
        if let zipcode = zipCodeField.text {
            if let wundergroundCurrentURL = URL(string: "http://api.wunderground.com/api/494caad0c14840f0/conditions/q/\(zipcode).json") {
                print(wundergroundCurrentURL)
                WUndergroundManager.getCurrentWeatherFromAPI(url: wundergroundCurrentURL, completion: { (currentWeather) in
                    if let weather = currentWeather {
                        self.setupCurrentWeatherView(currentWeather: weather)
                    }
                })
            }
        }
        
    }
    
    func setupCurrentWeatherView(currentWeather: CurrentWeather) {
        cityLabel = UILabel(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: 20))
        cityLabel.text = currentWeather.cityName
        cityLabel.textColor = .black
        view.addSubview(cityLabel)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.zipCodeField.resignFirstResponder()
    }
}
