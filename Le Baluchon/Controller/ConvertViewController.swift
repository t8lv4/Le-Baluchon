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
        currencyLabel.isEnabled = false
        calculerButton.isHidden = true
    }

}

// MARK: - Set up delegate

extension ConvertViewController: UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        convertTextField.delegate = self

        currencyLabel.layer.cornerRadius = 5
        calculerButton.layer.cornerRadius = 5
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)

        toggleActivityIndicator(activityIndicator, shown: false)
        currencyLabel.isEnabled = false
        currencyLabel.text = "€"

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        currencyLabel.text = "€"
        convertLabel.isEnabled = false
        currencyLabel.isEnabled = true
        calculerButton.isHidden = false
    }

}

// MARK: - Clear text field

extension ConvertViewController {
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)

        convertTextField.text = ""
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
     Check if the user input valid number

     - parameter input: the input to validate
        - If input is invalid, present an alert and empty text field
        - If not, call `conversionRequest(for:)`

     The method will replace a comma by a point to adress the european numeric keypad.
     */
    private func checkInputValidity(input: String) {
        // change comma to point for european numeric keypads
        if let number = Double(input.replacingOccurrences(of: ",", with: ".")) {
            requestConversion(for: number)
        } else {
            presentVCAlert(with: alertTitle.convertInputValidity.rawValue,
                           and: alertMessage.convertInputValidity.rawValue)
            convertTextField.text = ""
        }
    }

    /**
     Call several methods to display a converted currency.
     - get conversion rate from Fixer
     - update display
     - display an alert if the resource is not available
     */
    private func requestConversion(for amount: Double) {
        toggleActivityIndicator(activityIndicator,shown: true)

        APIService.shared.query(API: .Fixer) { (success, resource) in
            self.toggleActivityIndicator(self.activityIndicator, shown: false)

            if success, let rate = resource as? Double {
                self.updateDisplay(with: amount, and: rate)
            } else {
                self.presentVCAlert(with: alertTitle.failure.rawValue,
                                    and: alertMessage.convertRequest.rawValue)
            }
        }
    }

    /**
     Update display with a requested currency conversion.
     - Parameters:
        - amount: The user input value
        - rate: The rate provided by Fixer.io
     */
    private func updateDisplay(with amount: Double, and rate: Double) {
        convertTextField.text = Convert.convert(amount, with: rate)
        currencyLabel.text = "$"
    }

}
