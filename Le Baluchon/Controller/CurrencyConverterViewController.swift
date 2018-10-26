//
//  CurrencyConverterViewController.swift
//  Le Baluchon
//
//  Created by Morgan on 23/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    // MARK: - Outlets
    
    /// Link to Convert TextField
    @IBOutlet weak var convertTextField: UITextField!

}

// MARK: - Methods

///
extension CurrencyConverterViewController: UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.convertTextField.delegate = self
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // dim convertir label
        // toggle terminer button
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        convertTextField.becomeFirstResponder()

        guard let amount = convertTextField.text else { return false }
        checkInputValidity(input: amount)
        convertTextField.resignFirstResponder()
        return true
    }

}

// MARK: - Request service

extension CurrencyConverterViewController {

    /**
     Check if the user input a number (Double) to convert.

     - parameter input: the input to validate

     If valid, call `conversionRequest(for:)`.
     If not, present an alert.
     */
    func checkInputValidity(input: String) {
        let number = Double(input)
        if number != nil {
            conversionRequest(for: input)
        } else {
            presentVCAlert(with: "🧐", and: "Ceci n'es pas convertible en $...")
        }
    }

    /**
     Call several methods to display a converted currency.
     - get conversion rate from Fixer
     - display an alert if the resource is not available
     - get the value to display
     */
    func conversionRequest(for amount: String) {
        toggleActivityIndicator(shown: true)
        CurrencyConverterService.shared.query(url: Fixer.url) { (success, rate) in
            self.toggleActivityIndicator(shown: false)
            if success, let rate = rate {
                print("+++++++++++")
                print(rate)
                // call math
            } else {
                self.presentVCAlert(with: "😕", and: "Les données ne sont pas diponibles.")
            }
        }
    }
}

// MARK: - Pop-up alert

/// Extend the ViewController with a UIAlertController display
extension CurrencyConverterViewController {
    /**
     Define a UIAlertController called by the ViewController
     - A message is displayed according to the input
     - The user dismiss the alert by clicking a "OK" button

     - Parameters:
        - title: The alert's title
        - message: The error message to be displayed
     */
    func presentVCAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}

// MARK: Activity Indicator

extension CurrencyConverterViewController {

    /// Toggle an activity indicator
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
    }

}
