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
    /// Link to temperatures labels (outlet collection)
    @IBOutlet var tempLabels: [UILabel]!
    /// Link to weather condition icons (outlet collection)
    @IBOutlet var weatherIconViews: [UIImageView]!

}

// MARK: - Methods

extension WeatherViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)

        requestService()
    }

}

// MARK: - Request Weather resources

extension WeatherViewController {
    /**
     Request weather data from YahooWeather.
     - If available, call `display(_:)` to update UI
     - If not, call `presentVCAlert(with title:and message:)`
     */
    func requestService() {
        WeatherService.shared.request(YahooWeather.url) { (success, weatherCondition) in
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

    func display(_ weatherCondition: Weather) {
        print(weatherCondition.city)
        print(weatherCondition.temp)
        print(weatherCondition.code)
    }

    func handleRequestFailure() {
        presentVCAlert(with: "🙁", and: "La météo n'est pas disponible")
        // mod labels
    }

}
