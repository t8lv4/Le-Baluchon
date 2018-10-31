//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Morgan on 25/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: Properties

    /// Link to user current place label
    @IBOutlet weak var currentPlaceLabel: UILabel!
    /// Link to New-York Label
    @IBOutlet weak var NYLabel: UILabel!
    /**
     Link to temperatures labels (outlet collection)
        - [0] = display current user location temperature
        - [1] = display NY temperature
     */
    @IBOutlet var tempLabels: [UILabel]!
    /**
     Link to weather condition icons (outlet collection)
        - [0] = display current user location weather condition icon
        - [1] = display NY weather condition icon
     */
    @IBOutlet var weatherIconViews: [UIImageView]!

}

// MARK: - Methods

extension WeatherViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)

        let forecast = YahooWeather(city: Places.NewYork)
        let city = forecast.place
        requestService(for: city)
    }

}

// MARK: - Request Weather resources

extension WeatherViewController {
    /**
     Request weather data from YahooWeather.
     - If available, call `display(_:)` to update UI
     - If not, call `presentVCAlert(with title:and message:)`
     */
    func requestService(for city: String) {
        WeatherService.shared.request(for: city) { (success, weatherCondition) in
            guard let weatherCondition = weatherCondition else { return }

            if success {
                self.display(weatherCondition)
            } else {
                self.handleRequestFailure(for: weatherCondition)
            }
        }
    }

}

// MARK: - Update display

extension WeatherViewController {
    /**
     Update UI with the WeatherService response
     */
    func display(_ weatherCondition: Weather) {
        print(weatherCondition.city)
        print(weatherCondition.temp)
        print(weatherCondition.code)

        let iconName = Weather.getWeatherIcon(condition: Int(weatherCondition.code)!)

        tempLabels[1].text = weatherCondition.temp + "°"
        weatherIconViews[1].image = UIImage(named: iconName)

    }

    /**
     Present an alert and empty UI.
     */
    func handleRequestFailure(for weatherCondition: Weather) {
        presentVCAlert(with: "🙁", and: "La météo n'est pas disponible")
        // mod labels
        if weatherCondition.city != "New York" {
            NYLabel.text = "-"
            tempLabels[0].text = ""
            weatherIconViews[1].image = nil
        }


    }

}
