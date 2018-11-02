//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Morgan on 25/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {

    // MARK: Properties
    /// Link to Traduire label.
    @IBOutlet weak var traduireLabel: UILabel!
    /// Hold the words to be translated.
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak public var activityIndicator: UIActivityIndicatorView!

    // MARK: Methods
    /// Dismiss keyboard and update UI after tapping the view.
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translateTextField.resignFirstResponder()
        traduireLabel.isEnabled = true
        translateTextField.text = ""
    }
}

// MARK: -

/// Set up UITextFieldDelegate
extension TranslateViewController: UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.translateTextField.delegate = self
        toggleActivityIndicator(activityIndicator, shown: false)

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        traduireLabel.isEnabled = false
    }

}

// MARK: - Request

extension TranslateViewController {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        translateTextField.becomeFirstResponder()

        guard let text = translateTextField.text else { return false }
        checkInputValidity(input: text)
        
        return true
    }

    /**
     Check if the text input is an empty string.
        - if so: Present an alert
        - if not: Perform a translate request
     */
    private func checkInputValidity(input: String) {
        if translateTextField.text == "" {
            presentVCAlert(with: "😉", and: "Le traducteur demande un texte !")
        } else {
            translateRequest(for: input)
        }
    }

    /**
     Perform a translate request. If it succeed, update UI.
     - Parameters:
        - text: The user input

     If the request fail, present an alert
     */
    private func translateRequest(for text: String) {
        self.toggleActivityIndicator(activityIndicator,shown: true)

        TranslateService.shared.query(to: GoogleTranslation.url, with: text) { (success, translatedText) in
            if success, let translatedText = translatedText {
                self.toggleActivityIndicator(self.activityIndicator,shown: false)
                self.translateTextField.text = translatedText
            } else {
                self.toggleActivityIndicator(self.activityIndicator,shown: false)
                self.presentVCAlert(with: "😕", and: "La traduction n'est pas disponible")
            }
        }
    }

}
