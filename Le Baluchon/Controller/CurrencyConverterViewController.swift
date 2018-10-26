//
//  CurrencyConverterViewController.swift
//  Le Baluchon
//
//  Created by Morgan on 23/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    // MARK: - OUtlets
    
    /// Link to Convert TextField
    @IBOutlet weak var convertTextField: UITextField!

}

extension CurrencyConverterViewController: UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.convertTextField.delegate = self
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        convertTextField.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        convertTextField.becomeFirstResponder()

        guard let amount = convertTextField.text else { return false }
        conversionRequest(for: amount)
        convertTextField.resignFirstResponder()
        return true
    }

}

// MARK: - request Conversion

extension CurrencyConverterViewController {
    /**
     Call several methods to display a converted currency.
     - get conversion rate from Fixer
     - display an alert if the resource is not available
     - get the value to display
     */
    func conversionRequest(for amount: String) {
        CurrencyConverterService.shared.query(url: Fixer.url) { (success, rate) in
            if success, let rate = rate {
                print("+++++++++++")
                print(rate)
                // call math
            } else {
                self.presentVCAlert(with: "Les données ne sont pas diponibles")
            }
        }
    }
}

/// Extend the ViewController with a UIAlertController display
extension CurrencyConverterViewController {
    /**
     Define a UIAlertController called by the ViewController
     - A message is displayed according to the input
     - The user dismiss the alert by clicking a "OK" button

     - Parameter message: The error message to be displayed
     */
    func presentVCAlert(with message: String) {
        let alertVC = UIAlertController(title: "😕", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}
