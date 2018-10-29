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
        print("view did appear")

        //let place = Places.Paris
        print(YahooWeather.url)
        
        WeatherService.shared.request(YahooWeather.url) { (success, resource) in
            print(resource as Any)
        }
    }
}
