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
    
    func conversionRequest(for amount: String) {
        // pass values and method
        QueryService.shared.query(url: Fixer.url) { (success, rate) in
            if success, let rate = rate {
                print("+++++++++++")
                print(rate)
                // call math
            } else {
                // present alert
            }
        }
        // get rate and calculate
        // return value
    }
}
