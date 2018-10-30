//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Morgan on 25/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)

        requestService()

    }
}

// MARK: - Request Weather resources
extension WeatherViewController {

    func requestService() {
        WeatherService.shared.request(YahooWeather.url) { (success, weatherCondition) in
            if success, let weatherCondition = weatherCondition {
                self.display(weatherCondition)
            } else {
                // alert
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
}
