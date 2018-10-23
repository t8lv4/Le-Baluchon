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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.convertTextField.delegate = self
    }

}

extension CurrencyConverterViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        convertTextField.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        convertTextField.becomeFirstResponder()

        guard let convert = convertTextField.text else { return false }
        // call conversion task
        convertTextField.resignFirstResponder()
        return true
    }

}
