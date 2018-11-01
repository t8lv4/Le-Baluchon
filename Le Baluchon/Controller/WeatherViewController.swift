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

    /** Link to place labels (outlet collection)
    - [0] = display current user location temperature
    - [1] = display NY temperature
     */
    @IBOutlet var placeLabels: [UILabel]!
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

    /// Link to activity indicators (outlet collection)
    @IBOutlet var activityIndicators: [UIActivityIndicatorView]!

}

// MARK: - Methods

extension WeatherViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        for index in 0...1 {
            placeLabels[index].text = "-"
            tempLabels[index].text = ""
            weatherIconViews[index].image = nil

        }
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
        for activityIndicator in activityIndicators {
            toggleActivityIndicator(activityIndicator, shown: true)
        }

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
        switch weatherCondition.city {
        case "Paris":
            toggleActivityIndicator(activityIndicators[0], shown: false)

            placeLabels[0].text = "Paris"
            tempLabels[0].text = weatherCondition.temp + "°"
            let iconName = Weather.getWeatherIcon(condition: Int(weatherCondition.code)!)
            weatherIconViews[0].image = UIImage(named: iconName)

        case "New York":
            toggleActivityIndicator(activityIndicators[1], shown: false)

            placeLabels[1].text = "New-York"
            tempLabels[1].text = weatherCondition.temp + "°"
            let iconName = Weather.getWeatherIcon(condition: Int(weatherCondition.code)!)
            weatherIconViews[1].image = UIImage(named: iconName)

        default:
            return
        }
    }

    /**
     Present an alert and empty UI.
     */
    func handleRequestFailure() {
        presentVCAlert(with: "🙁", and: "La météo n'est pas disponible")
            placeLabels[1].text = "-"
            tempLabels[1].text = ""
            weatherIconViews[1].image = nil
    }

}
