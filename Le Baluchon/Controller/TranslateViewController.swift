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
    @IBOutlet weak var traduireLabel: UILabel!
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: Methods
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
        toggleActivityIndicator(shown: false)

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
        translateRequest(for: text)

        return true
    }

    private func translateRequest(for text: String) {
        self.toggleActivityIndicator(shown: true)

        TranslateService.shared.query(to: GoogleTranslation.url, with: text) { (success, translatedText) in
            if success, let translatedText = translatedText {
                self.toggleActivityIndicator(shown: false)
                self.translateTextField.text = translatedText
            } else {
                self.toggleActivityIndicator(shown: false)
                self.presentVCAlert(with: "😕", and: "La traduction n'est pas disponible")
            }
        }
    }

}

// MARK: Activity Indicator

extension TranslateViewController {

    /// Toggle an activity indicator
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
    }

}

// MARK: - Pop-up alert

/// Extend the ViewController with a UIAlertController display
extension TranslateViewController {
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
