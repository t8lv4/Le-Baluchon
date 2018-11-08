//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Morgan on 25/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: Properties

    let locationManager = CLLocationManager()

    /** Link to place labels (outlet collection)
    - [0] = display the name of the current user location
    - [1] = display NY name
     */
    @IBOutlet var placeLabels: [UILabel]!
    /**
     Link to temperatures labels (outlet collection)
        - [0] = display the current user location temperature
        - [1] = display NY temperature
     */
    @IBOutlet var tempLabels: [UILabel]!
    /**
     Link to weather condition icons (outlet collection)
        - [0] = display the current user location's weather condition icon
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

        locationManager.requestWhenInUseAuthorization()
        startReceivingLocationChanges()

        placeLabels[0].minimumScaleFactor = 0.5
        placeLabels[0].adjustsFontSizeToFitWidth = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)

        if CLLocationManager.authorizationStatus() != .denied {
            setUpDisplay()
            if Places.cities.count != 1 { callService() }
        } else {
            locationAuthorizationAlert()
        }
    }

}

// MARK: - Request Weather resources

extension WeatherViewController {

    /**
     Call `requestService` for each city in `Places.cities[String: Any]`
     */
    private func callService() {
        for cities in Places.cities.values {
            let forecast = YahooWeather(city: cities)
            let city = forecast.place
            requestService(for: city)
        }
    }

    /**
     Request weather data from YahooWeather.
     - If available, call `display(_:)` to update UI
     - If not, call `presentVCAlert(with title:and message:)`
     */
    private func requestService(for city: String) {
        for activityIndicator in activityIndicators {
            toggleActivityIndicator(activityIndicator, shown: true)
        }

        WeatherService.shared.query(for: city) { (success, weatherCondition) in
            if success, let weatherCondition = weatherCondition {
                self.display(weatherCondition)
            } else {
                self.handleRequestFailure(weatherCondition) // add city, puis switch
            }
        }
    }

}

// MARK: - Update display

extension WeatherViewController {

    /**
     Set up UI for a blank state

     Called inside viewWillAppear().
     */
    private func setUpDisplay() {
        for index in 0...1 {
            placeLabels[index].text = ""
            tempLabels[index].text = ""
            weatherIconViews[index].image = nil

        }
    }

    /**
     Update UI with the WeatherService response
     */
    private func display(_ weatherCondition: Weather) {
        switch weatherCondition.city {
        case "New York":
            toggleActivityIndicator(activityIndicators[1], shown: false)

            placeLabels[1].text = "New York"
            tempLabels[1].text = weatherCondition.temp + "°"
            let iconName = Weather.getWeatherIcon(condition: Int(weatherCondition.code)!)
            weatherIconViews[1].image = UIImage(named: iconName)

        // user current location
        default:
            toggleActivityIndicator(activityIndicators[0], shown: false)

            placeLabels[0].text = weatherCondition.city
            tempLabels[0].text = weatherCondition.temp + "°"
            let iconName = Weather.getWeatherIcon(condition: Int(weatherCondition.code)!)
            weatherIconViews[0].image = UIImage(named: iconName)
        }
    }

    /**
     Present an alert and empty UI.
     */
    func handleRequestFailure(_ weatherCondition: Weather?) {
        for activityIndicator in activityIndicators {
            toggleActivityIndicator(activityIndicator, shown: false)
        }
        presentVCAlert(with: alertTitle.weatherRequest.rawValue,
                       and: alertTitle.weatherRequest.rawValue)
    }

    /**
     Present an alert if the user didn't grant access to location
     */
    func locationAuthorizationAlert() {
        setUpDisplay()
        for activityIndicator in activityIndicators {
            toggleActivityIndicator(activityIndicator, shown: false)
        }
        presentVCAlert(with: alertTitle.locationAuth.rawValue,
                       and: alertMessage.locationAuth.rawValue)
    }

}

// MARK: User Location

extension WeatherViewController {

    private func startReceivingLocationChanges() {
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 1000.0  // In meters.
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last!
        locationManager.stopUpdatingLocation()

        Places.addCurrentLocation((lastLocation.coordinate.latitude, lastLocation.coordinate.longitude))

        callService()
        }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            break
        case .authorizedWhenInUse:
            // If authorized when in use
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            // If always authorized
            manager.startUpdatingLocation()
            break
        case .restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            locationAuthorizationAlert()
            break
        default:
            break
        }
    }

}
