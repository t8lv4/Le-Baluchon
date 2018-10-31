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

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)

//        let currentCoordinates = (48.856614, 2.3522219)
//        Places.addCurrentLocation(currentCoordinates)
//        let currentLocation = Places.cities["currentLocation"]
//        print(currentLocation!)
//
//        let f = YahooWeather(city: Places.cities["currentLocation"]!)
//        print("=========")
//        print(Places.cities["currentLocation"]!)
//        let c = f.place
//        print(c)
//        requestService(for: c)
//
//        let currentCoordinates = (48.856614, 2.3522219)
//        let forecastW = YahooWeather(city: currentCoordinates)
//        let currentPlace = forecastW.place
//        print(currentPlace)
//        requestService(for: currentPlace)
//
//        let forecast = YahooWeather(city: Places.cities["New-York"]!)
//        print("--------")
//        print(Places.cities["New-York"]!)
//        let city = forecast.place
//        print(city)
//        requestService(for: city)

        for cities in Places.cities.values {
            let forecast = YahooWeather(city: cities)
            let city = forecast.place
            requestService(for: city)
            print(city)
        }
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
            if success, let weatherCondition = weatherCondition {
                self.display(weatherCondition)
            } else {
                self.handleRequestFailure()
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
        // switch sur .city pout update UI
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
    func handleRequestFailure() {
        presentVCAlert(with: "🙁", and: "La météo n'est pas disponible")
            NYLabel.text = "-"
            tempLabels[1].text = ""
            weatherIconViews[1].image = nil


    }

}
