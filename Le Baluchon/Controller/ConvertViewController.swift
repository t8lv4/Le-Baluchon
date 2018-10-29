//
//  ConvertViewController.swift
//  Le Baluchon
//
//  Created by Morgan on 23/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController {

    // MARK: Outlets
    
    /// Link to "Convertir" label.
    @IBOutlet weak var convertLabel: UILabel!
    /// Link to user input text.
    @IBOutlet weak var convertTextField: UITextField!
    @IBOutlet weak public var activityIndicator: UIActivityIndicatorView!
    /// Link to currency icon.
    @IBOutlet weak var currencyLabel: UILabel!
    /// Link to calculer button.
    @IBOutlet weak var calculerButton: UIButton!

    // MARK: Methods

    @IBAction func tappedCalculerButton(_ sender: UIButton) {
        launchRequest()
    }

    @IBAction func dismissKeyboard(_ sender: UIGestureRecognizer) {
        convertTextField.resignFirstResponder()

        convertLabel.isEnabled = true
        calculerButton.isHidden = true
    }

}

// MARK: - Set up delegate

extension ConvertViewController: UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.convertTextField.delegate = self
        toggleActivityIndicator(activityIndicator, shown: false)

        self.currencyLabel.layer.cornerRadius = 5
        self.calculerButton.layer.cornerRadius = 5
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        currencyLabel.text = "€"
        convertLabel.isEnabled = false
        calculerButton.isHidden = false
    }

}

// MARK: - Clear text field

extension ConvertViewController {
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)

        self.convertTextField.text = ""
    }
}

// MARK: - Request service

extension ConvertViewController {

    /**
     Launch the request process.
     - enable keyboard
     - call `checkInputValidity(input:)`
     - update the state of UI objects
     */
    private func launchRequest() {
        convertTextField.becomeFirstResponder()

        guard let amount = convertTextField.text else { return }
        checkInputValidity(input: amount)

        convertTextField.resignFirstResponder()
        convertLabel.isEnabled = true
        calculerButton.isHidden = true
    }

    /**
     Check if the user input a number to convert.

     - parameter input: the input to validate

     - If valid, call `conversionRequest(for:)`
     - If not, present an alert
     */
    private func checkInputValidity(input: String) {
        if let number = Double(input) {
            conversionRequest(for: number)
        } else {
            presentVCAlert(with: "🤓", and: "Ceci n'est pas convertible en $...")
        }
    }

    /**
     Call several methods to display a converted currency.
     - get conversion rate from Fixer
     - display an alert if the resource is not available
     */
    private func conversionRequest(for amount: Double) {
        toggleActivityIndicator(activityIndicator,shown: true)

        ConvertService.shared.query(to: Fixer.url) { (success, rate) in
            self.toggleActivityIndicator(self.activityIndicator,shown: false)

            if success, let rate = rate {
                self.updateDisplay(with: amount, and: rate)
            } else {
                self.presentVCAlert(with: "😕", and: "Les données ne sont pas disponibles.")
            }
        }
    }

    /**
     Use the rate value from the API request to display a converted currency.
     - Parameters:
        - amount: The user input value
        - rate: The rate provided by Fixer.io
     */
    private func updateDisplay(with amount: Double, and rate: Double) {
        let convertedCurrency = Convert.convert(amount, with: rate)
        self.convertTextField.text = convertedCurrency
        self.currencyLabel.text = "$"
    }
}
